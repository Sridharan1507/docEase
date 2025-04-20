import 'package:docease_1/constant.dart';
import 'package:docease_1/doctor/doctor_bloc.dart';
import 'package:docease_1/doctor/doctor_event.dart';
import 'package:docease_1/doctor/doctor_state.dart';
import 'package:docease_1/model/doctor/doctor.dart';
import 'package:docease_1/model/patient/patient.dart';
import 'package:docease_1/pages/home.dart';
import 'package:docease_1/pages/schedule_Appointment.dart';
import 'package:docease_1/patient/patiemt_bloc.dart';
import 'package:docease_1/patient/patient_event.dart';
import 'package:docease_1/patient/patient_state.dart';
import 'package:docease_1/shared_prefrenec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HealthRecordsPage extends StatefulWidget {
  const HealthRecordsPage({Key? key}) : super(key: key);

  @override
  _HealthRecordsPageState createState() => _HealthRecordsPageState();
}

class _HealthRecordsPageState extends State<HealthRecordsPage> {
  List<GetAllPrescriptionsData>? getAllPrescriptions = [];
  PatientBloc patientBloc = PatientBloc();
  List<DoctorsDetailsResponseData> doctorDetails = [];
  List<GetUserDetailsData>? userDetails = [];
  buildListernerPatient(context, state) {
    if (state is GetAllprescriptionsLoadingState) {
      print("GetAllprescriptionsLoadingState");
    } else if (state is GetAllprescriptionsLoadedState) {
      print("GetAllprescriptionsLoadedState");
      getAllPrescriptions = state.getAllPrescriptions;
      doctorBloc.add(GetUSerDetailEvent());
      

      print("getAllPrescriptions ${getAllPrescriptions!.length}");
    }
  }

  buildListernerDoctor(context, state) {
    if (state is GetDoctorDetailsLoadingState) {
      print("doctoe loasding");
    } else if (state is GetDoctorDetailsLoadedState) {
      print("loaded docotr");
      doctorDetails = state.authResponse!;
      
    }
    if (state is GetUserDetailsLoadingState) {
      print("user detailsloading");
    } else if (state is GetUserDetailsLoadedState) {
      print("user detials loaded");
      userDetails = state.getuserDetails;

      if(userDetails!.first.rOLE =="doctor"){
doctorBloc.add(GetPatientsDetailsEvent());
      }
      else{
        doctorBloc.add(GetDoctorDetailsEvent());
      }
      

      print("userDetails ${userDetails!.first.email}");
    }
    if (state is GetPatientDetailsLoadingState) {
      print("doctoe loasding");
    } else if (state is GetPatientDetailsLoadedState) {
      print("loaded docotr");
      doctorDetails = state.patientres!;
    }
  }


  DoctorBloc doctorBloc = DoctorBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    patientBloc.add(GetAllPrescriptionsEvent());
  }

  void showHtmlPopup(BuildContext context, String htmlContent) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SingleChildScrollView(
            child: Container(
              height: 600,
              child: HtmlWidget(
                htmlContent,
                textStyle: TextStyle(fontSize: 14),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PatientBloc>(create: (context) => PatientBloc()),
        BlocProvider<DoctorBloc>(create: (context) => DoctorBloc()),
      ],
      child: BlocConsumer(
        bloc: patientBloc,
        listener: (context, state) {
          buildListernerPatient(context, state);
        },
        builder: (context, state) {
          return BlocConsumer<DoctorBloc, DoctorState>(
            bloc: doctorBloc,
            listener: (context, state) {
              buildListernerDoctor(context, state);
            },
            builder: (context, state) {
              if (state is GetDoctorDetailsLoadingState) {
                return Scaffold(body: Center(child: Text("Please wait")));
              } else if (state is GetDoctorDetailsLoadedState || state is GetPatientDetailsLoadedState) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: const Text("Health Records"),
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  body: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: getAllPrescriptions!.length,
                    itemBuilder: (context, index) {
                      return _buildRecordCard(getAllPrescriptions![index]);
                    },
                  ),
                  bottomNavigationBar: SafeArea(
                    bottom: false,
                    child: BottomNavigationBar(
                      currentIndex: 2,
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.indigo,
                      unselectedItemColor: Colors.grey,
                      items: [
                        BottomNavigationBarItem(
                          icon: GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                                (Route<dynamic> route) => route.isFirst,
                              );
                            },
                            child: const Icon(Icons.home),
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VaccineFollowUpScreen(),
                                ),
                                (Route<dynamic> route) => route.isFirst,
                              );
                            },
                            child: const Icon(Icons.calendar_month),
                          ),
                          label: 'Appointments',
                        ),
                        BottomNavigationBarItem(
                          icon: GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.person),
                          ),
                          label: 'Records',
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            },
          );
        },
      ),
    );
  }

  findDoctorName(String? id, List<DoctorsDetailsResponseData> doctorsList) {
    final matchedDoctor = doctorsList.firstWhere(
      (doctor) => doctor.id == id,
      orElse: () => DoctorsDetailsResponseData(name: 'Unknown'),
    );

    return "${matchedDoctor.name}_${matchedDoctor.specialist}";
  }

  void _showBanner2(BuildContext context, String htmlStringContent) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        8,
                      ), // Curve the container edges
                    ),
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        htmlStringContent,
                        textStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -28, // Position the close icon from the top
                right: 4, // Position the close icon from the right
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecordCard(GetAllPrescriptionsData record) {
    String docName = findDoctorName(record.doctorId, doctorDetails);
    String patientName = findDoctorName(record.patientId, doctorDetails);
    return GestureDetector(
      onTap: () async {
        String htmlStringContent = '';
        String token = await SharedPreference.getAuthToken();
        print("token $token");
        Map<String, String> headers = {};

        headers = {"localtonet-skip-warning": "true", "Token": token};

        var response = await http.get(
          Uri.parse("$baseURL/my_prescription/${record.prescriptionId}/html"),
          headers: headers,
        );

        if (response.statusCode == 200) {
          htmlStringContent = response.body;

          _showBanner2(context, htmlStringContent);
        } else {
          Fluttertoast.showToast(
            msg: "Something went Wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red.shade400,
            textColor: Colors.white,
            fontSize: 12.0,
          );
        }
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat(
                        'dd',
                      ).format(DateTime.parse(record.createdAt!)),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat(
                        'MMM',
                      ).format(DateTime.parse(record.createdAt!)),
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      DateFormat(
                        'yyyy',
                      ).format(DateTime.parse(record.createdAt!)),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(record.time, style: const TextStyle(fontSize: 13)),
                    // const SizedBox(height: 4),
                    Text(
                   userDetails!.first.rOLE =='doctor' ?patientName.split("_")[0]:  "${userDetails!.first.name!} Prescription",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                   userDetails!.first.rOLE =="doctor"?"Consulted by Dr. ${userDetails!.first.name}":   "Consulted by Dr. ${docName.split("_")[0]}"  ,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.vaccines, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

class HealthRecord {
  final String day;
  final String month;
  final String time;
  final String title;
  final String doctor;
  final String year;

  HealthRecord(
    this.day,
    this.month,
    this.time,
    this.title,
    this.doctor,
    this.year,
  );
}

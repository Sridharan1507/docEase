import 'package:docease_1/doctor/doctor_bloc.dart';
import 'package:docease_1/doctor/doctor_event.dart';
import 'package:docease_1/doctor/doctor_state.dart';
import 'package:docease_1/main.dart';
import 'package:docease_1/model/doctor/doctor.dart';
import 'package:docease_1/model/patient/patient.dart';
import 'package:docease_1/pages/home.dart';
import 'package:docease_1/pages/record.dart';
import 'package:docease_1/patient/patiemt_bloc.dart';
import 'package:docease_1/patient/patient_event.dart';
import 'package:docease_1/patient/patient_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class VaccineFollowUpScreen extends StatefulWidget {
  const VaccineFollowUpScreen({super.key});

  @override
  State<VaccineFollowUpScreen> createState() => _VaccineFollowUpScreenState();
}

class _VaccineFollowUpScreenState extends State<VaccineFollowUpScreen> {
  final List<Map<String, String>> specialty = [
    {
      "id": "1",
      "name": "Cardiologist",
      "Description": "Specializes in diagnosing and treating heart conditions.",
    },
    {
      "id": "2",
      "name": "Dermatologist",
      "Description": "Focuses on skin, hair, and nail disorders.",
    },
    {
      "id": "3",
      "name": "Neurologist",
      "Description": "Deals with disorders of the nervous system.",
    },
    {
      "id": "4",
      "name": "Orthopedic Surgeon",
      "Description":
          "Treats musculoskeletal system issues, including bones and joints.",
    },
    {
      "id": "5",
      "name": "Pediatrician",
      "Description":
          "Provides medical care for infants, children, and adolescents.",
    },
    {
      "id": "6",
      "name": "test_specialist",
      "Description": "test_specialistdesc",
    },
    {
      "id": "7",
      "name": "Pediatrician_test",
      "Description": "test_Pediatrician",
    },
  ];

  PatientBloc patientBloc = PatientBloc();
  DoctorBloc doctorBloc = DoctorBloc();
  findDoctorName(String? id, List<DoctorsDetailsResponseData> doctorsList) {
    final matchedDoctor = doctorsList.firstWhere(
      (doctor) => doctor.id == id,
      orElse: () => DoctorsDetailsResponseData(name: 'Unknown'),
    );

    return "${matchedDoctor.name}_${matchedDoctor.specialist}";
  }

  String getSpecialistNameById(String id) {
    final match = specialty.firstWhere(
      (element) => element["id"] == id,
      orElse: () => {},
    );
    return match["name"] ?? "Pediatrician";
  }

  Widget buildVaccineCard(GetpatientAppointmentResData item) {
    String docName = findDoctorName(item.doctorId, doctorDetails);
     String patientName = findDoctorName(item.patientId, doctorDetails);
    ;
    String name = getSpecialistNameById(docName.split("_")[1] ?? "5");

    final now = DateTime.now();
final today = DateTime(now.year, now.month, now.day); // Strips time

final date = DateTime.parse(item.appointmentDate!);
final appointmentDateOnly = DateTime(date.year, date.month, date.day);


    return (appointmentDateOnly.isAtSameMomentAs(today) || appointmentDateOnly.isAfter(today)) ?Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info Row
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFF4C63B6),
                  backgroundImage: AssetImage("lib/assets/images/doctor.png"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       userDetails!.first.rOLE =="doctor"?"Dr. ${userDetails!.first.name}":  "Dr. ${docName.split("_")[0]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(name, style: const TextStyle(color: Colors.grey)),
                      Text(
                      userDetails!.first.rOLE =="doctor"?  patientName.split("_")[0]:"${userDetails!.first.name}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Due Date",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      DateFormat("dd MMM yyyy")
                          .format(DateTime.parse(item.appointmentDate!))
                          .toUpperCase(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action Buttons
            item.status == "scheduled"
                ? Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _showInputDialog(context);
                        },
                        child: Text("Call"),
                      ),
                    ),
                  ],
                )
                : SizedBox(),
          ],
        ),
      ),
    ):SizedBox();
  }

  void _showInputDialog(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Call ID'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "call ID"),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('ok'),
              onPressed: () {
                String inputText = _textFieldController.text;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CallPage(callID: inputText),
                  ),
                );
                // Navigator.of(context).pop(); // Close dialog
                print("User entered: $inputText"); // Do something with it
              },
            ),
          ],
        );
      },
    );
  }

  List<GetpatientAppointmentResData>? getAppointments = [];

  @override
  void initState() {
    // TODO: implement initState
    patientBloc.add(GetAppointmentsEvent());
    super.initState();
  }

  buildListernerPatient(context, state) {
    if (state is GetPatientAppoinmentLoadingState) {
      print("GetPatientAppoinmentLoadingState");
    } else if (state is GetPatientAppoinmentLoadedState) {
      print("GetPatientAppoinmentLoadedState");
      getAppointments = state.getAppointments;
      doctorBloc.add(GetUSerDetailEvent());
    }
  }

  List<DoctorsDetailsResponseData> doctorDetails = [];
  List<GetUserDetailsData>? userDetails = [];
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

      if(userDetails!.first.rOLE == "doctor"){
doctorBloc.add(GetPatientsDetailsEvent());
      }
      else{
        doctorBloc.add(GetDoctorDetailsEvent());
      }

      print("userDetails ${userDetails!.first.email}");
    }
    if (state is GetPatientDetailsLoadingState) {
      print("patients loasding");
    } else if (state is GetPatientDetailsLoadedState) {
      print("loaded patienst");
      doctorDetails = state.patientres!;
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PatientBloc>(create: (context) => PatientBloc()),
      ],
      child: BlocConsumer(
        bloc: patientBloc,
        listener: (context, state) {
          buildListernerPatient(context, state);
        },
        builder: (context, PatientState state) {
          return BlocConsumer<DoctorBloc, DoctorState>(
            bloc: doctorBloc,
            listener: (context, state) {
              buildListernerDoctor(context, state);
            },
            builder: (context, state) {
              if (state is GetDoctorDetailsLoadingState || state is GetPatientDetailsLoadingState) {
                return Scaffold(body: Center(child: Text("Please wait")));
              } else if (state is GetDoctorDetailsLoadedState || state is GetPatientDetailsLoadedState) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    title: const Text("Scheduled Appointment"),
                    centerTitle: true,
                    elevation: 5,
                  ),
                  body: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: getAppointments!.length,
                    itemBuilder: (context, index) {
                      return buildVaccineCard(getAppointments![index]);
                    },
                  ),
                  bottomNavigationBar:  SafeArea(
                bottom: false, // Prevent extra space at the bottom
                child: BottomNavigationBar(
                  currentIndex: 0,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.indigo,
                  unselectedItemColor: Colors.grey,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                      icon: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VaccineFollowUpScreen()),
                            (Route<dynamic> route) => route.isFirst,
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (_) => VaccineFollowUpScreen()),
                          // );
                        },
                        child: Icon(Icons.calendar_month),
                      ),
                      label: 'Appointments',
                    ),
                    BottomNavigationBarItem(
                      icon: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HealthRecordsPage()),
                            (Route<dynamic> route) => route.isFirst,
                          );
                        },
                        child: Icon(Icons.person),
                      ),
                      label: 'Records',
                    ),
                  ],
                ),
              ), );
              }
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            },
          );
        },
      ),
    );
  }
}

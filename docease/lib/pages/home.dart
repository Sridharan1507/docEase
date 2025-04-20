import 'package:docease_1/doctor/doctor_bloc.dart';
import 'package:docease_1/doctor/doctor_event.dart';
import 'package:docease_1/doctor/doctor_state.dart';
import 'package:docease_1/model/doctor/doctor.dart';
import 'package:docease_1/pages/add_prescriptions.dart';
import 'package:docease_1/pages/doctor_Details.dart';
import 'package:docease_1/pages/record.dart';
import 'package:docease_1/pages/schedule_Appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Doctor {
  final String name;
  final String specialty;
  final String time;
  final double rating;
  final String imageUrl;

  Doctor({
    required this.name,
    required this.specialty,
    required this.time,
    required this.rating,
    required this.imageUrl,
  });
}

List<Doctor> doctors = [
  Doctor(
    name: 'Dr. Hamza Tariq',
    specialty: 'Senior Surgeon(Odontology)',
    time: '10:30 AM - 3:30 PM',
    rating: 4.9,
    imageUrl:
        'https://images.pexels.com/photos/8460154/pexels-photo-8460154.jpeg',
  ),
  Doctor(
    name: 'Dr. Alina Fatima',
    specialty: 'Senior Surgeon(Cardiology)',
    time: '10:30 AM - 3:30 PM',
    rating: 5.0,
    imageUrl:
        'https://images.pexels.com/photos/6749774/pexels-photo-6749774.jpeg',
  ),
];

// class HomeScreen extends StatefulWidget {

//   buildListernerDoctor(context,state){

//     if(state is GetDoctorDetailsLoadingState){
//       print("doctoe loasding");
//     }
//     else if ( state is GetDoctorDetailsLoadedState){
//       print("loaded docotr");
//     }

//   }

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class ServiceIcon extends StatelessWidget {
  final String title;
  // final IconData icon;
  final String icondata;

  const ServiceIcon({required this.title, required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          radius: 22,
          backgroundImage: AssetImage(icondata),
          // child:icon==Icons.add?SizedBox(): Icon(icon, color: Colors.blue),
        ),
        SizedBox(height: 4),
        Text(title, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

class DoctorDetailScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailScreen({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(doctor.name)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(doctor.imageUrl),
              ),
            ),
            SizedBox(height: 20),
            Text(
              doctor.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(doctor.specialty),
            SizedBox(height: 20),
            Text('Available Time: ${doctor.time}'),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: Text('Book Appointment')),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController userNameTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DoctorBloc doctorBloc = DoctorBloc();
  @override
  void initState() {
    doctorBloc.add(GetUSerDetailEvent());

    super.initState();
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

      if (userDetails!.first.rOLE == "doctor") {
        doctorBloc.add(GetPatientsDetailsEvent());
      } else {
        doctorBloc.add(GetDoctorDetailsEvent());
      }

      print("userDetails ${userDetails!.first.email}");
    }

    if (state is GetPatientDetailsLoadingState) {
      print("user GetPatientDetailsLoadingState");
    } else if (state is GetPatientDetailsLoadedState) {
      doctorDetails = state.patientres!;
    }
  }

  Widget buildDoctorCard(DoctorsDetailsResponseData doctor, int index) {
    final List<Map<String, String>> specialty = [
      {
        "id": "1",
        "name": "Cardiologist",
        "Description":
            "Specializes in diagnosing and treating heart conditions.",
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

    final List<String> specialistDescriptions = [
      "is the topmost cardiologist at Crist Hospital in London, UK. He has been honored multiple times for his groundbreaking work in heart care and treatment.",
      "is a leading dermatologist at Sunshine Skin Clinic in New York, USA. Her expertise in treating rare skin disorders has earned her global recognition.",
      "is a highly respected neurologist at NeuroCare Centre in Toronto, Canada. His pioneering research in brain and nervous system diseases has won him international acclaim.",
      "is one of the most sought-after orthopedic surgeons at MotionPlus Hospital in Barcelona, Spain. She is widely recognized for her advanced joint replacement techniques.",
      "is a renowned pediatrician at LittleCare Hospital in Sydney, Australia. Her dedication to child healthcare has touched the lives of thousands of families.",
      "is a test_specialist at Sample Clinic in Testville. His contributions to the field of testing have set a new benchmark in diagnostics.",
      "is known as a pediatrician_test at Beta Hospital in Mock City. She continues to innovate in child medicine and experimental pediatric care.",
    ];

    String getSpecialistNameById(String id) {
      final match = specialty.firstWhere(
        (element) => element["id"] == id,
        orElse: () => {},
      );
      return match["name"] ?? "Pediatrician";
    }

    String name = getSpecialistNameById(doctor.specialist ?? "5");
    int descIndex = int.tryParse(doctor.specialist ?? "6") ?? 6;

    return GestureDetector(
      onTap: () {
        if (userDetails!.first.rOLE == "doctor") {
          print("in doctor flow");
print(doctor.name);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPrescriptionScreen(doctorID: doctor.id!),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => DoctorProfilePage(
                    doctorName: 'Dr. ${doctor.name}',
                    designation: '$name and Surgeon',
                    imagePath: 'lib/assets/images/doctor.png',
                    rating: 4.9,
                    reviews: 96,
                    patients: 116,
                    years: 3,
                    totalReviews: 90,
                    about:
                        'Dr. ${doctor.name} ${specialistDescriptions[descIndex]}',
                    doctorID: doctor.id!,
                  ),
            ),
          );
        }
      },
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading:
              userDetails!.first.rOLE == "doctor"
                  ? CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF4C63B6),
                    child: Icon(Icons.person, size: 24, color: Colors.white),
                  )
                  : CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFF4C63B6),
                    backgroundImage: AssetImage("lib/assets/images/doctor.png"),
                  ),
          title:
              userDetails!.first.rOLE == "doctor"
                  ? Text("${doctor.name!} -  ${doctor.gender!}")
                  : Text("Dr. ${doctor.name!}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userDetails!.first.rOLE == "doctor"
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(doctor.mobileNumber!),

                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Add Prescription",
                          style: TextStyle(fontSize: 13, color: Colors.indigo),
                        ),
                      ),
                    ],
                  )
                  : Text(name),
              userDetails!.first.rOLE == "doctor"
                  ? SizedBox()
                  : const Text('⏰ Full day', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DoctorBloc>(create: (context) => DoctorBloc()),
        // Actdd more BLoC providers as needed
      ],
      child: BlocConsumer<DoctorBloc, DoctorState>(
        bloc: doctorBloc,
        listener: (context, state) {
          buildListernerDoctor(context, state);
        },
        builder: (context, DoctorState state) {
          if (state is GetDoctorDetailsLoadingState) {
            return Scaffold(body: Center(child: Text("Please wait")));
          } else if (state is GetDoctorDetailsLoadedState ||
              state is GetPatientDetailsLoadedState) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              userDetails!.first.rOLE == "doctor"
                                  ? "lib/assets/images/doctor.png"
                                  : "lib/assets/images/profile.png",
                            ),
                          ),
                          Icon(Icons.settings, color: Colors.grey.shade700),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        userDetails!.first.rOLE == "doctor"
                            ? 'Hello  Dr.${userDetails!.first.name}!'
                            : 'Hello ${userDetails!.first.name}!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      SearchBar(),
                      SizedBox(height: 20),
                      userDetails!.first.rOLE == "doctor"
                          ? SizedBox()
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Services',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ServiceIcon(
                                    title: 'Odontology',
                                    icondata:
                                        "lib/assets/images/tooth-pain.png",
                                  ),
                                  ServiceIcon(
                                    title: 'Neurology',
                                    icondata: "lib/assets/images/neurology.png",
                                  ),
                                  ServiceIcon(
                                    title: 'Cardiology',
                                    icondata:
                                        "lib/assets/images/cardiology.png",
                                  ),
                                  ServiceIcon(
                                    title: 'Nephrology',
                                    icondata:
                                        "lib/assets/images/kidney (1).png",
                                  ),
                                  ServiceIcon(
                                    title: 'Pulmonology',
                                    icondata:
                                        "lib/assets/images/pulmonology.png",
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),

                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          userDetails!.first.rOLE == "doctor"
                              ? "My Patients"
                              : 'Top Doctors',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: doctorDetails.length,
                          itemBuilder: (context, index) {
                            final doc = doctorDetails[index];
                            return buildDoctorCard(doc, index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar:
                  userDetails!.first.rOLE == "doctor"
                      ? SafeArea(
                        bottom: false, // Prevent extra space at the bottom
                        child: BottomNavigationBar(
                          currentIndex: 0,
                          type: BottomNavigationBarType.fixed,
                          selectedItemColor: Colors.indigo,
                          unselectedItemColor: Colors.grey,
                          items: [
                            BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => VaccineFollowUpScreen(),
                                    ),
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
                                      builder: (context) => HealthRecordsPage(),
                                    ),
                                    (Route<dynamic> route) => route.isFirst,
                                  );
                                },
                                child: Icon(Icons.person),
                              ),
                              label: 'Records',
                            ),
                          ],
                        ),
                      )
                      : SafeArea(
                        bottom: false, // Prevent extra space at the bottom
                        child: BottomNavigationBar(
                          currentIndex: 0,
                          type: BottomNavigationBarType.fixed,
                          selectedItemColor: Colors.indigo,
                          unselectedItemColor: Colors.grey,
                          items: [
                            BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => VaccineFollowUpScreen(),
                                    ),
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
                                      builder: (context) => HealthRecordsPage(),
                                    ),
                                    (Route<dynamic> route) => route.isFirst,
                                  );
                                },
                                child: Icon(Icons.person),
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
      ),
    );
  }
}

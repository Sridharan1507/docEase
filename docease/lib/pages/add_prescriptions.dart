import 'dart:convert';

import 'package:docease_1/constant.dart';
import 'package:docease_1/doctor/doctor_bloc.dart';
import 'package:docease_1/doctor/doctor_event.dart';
import 'package:docease_1/doctor/doctor_state.dart';
import 'package:docease_1/model/doctor/doctor.dart';
import 'package:docease_1/pages/doctor_Appointment.dart';
import 'package:docease_1/pages/home.dart';
import 'package:docease_1/pages/record.dart';
import 'package:docease_1/pages/schedule_Appointment.dart';
import 'package:docease_1/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPrescriptionScreen extends StatefulWidget {
  final String doctorID;

  const AddPrescriptionScreen({super.key, required this.doctorID});

  _AddPrescriptionScreenState createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  TextEditingController userNameTextEditingController = TextEditingController();

  TextEditingController notesTextEditingController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  List<String> dosage = [
    "After Meal 0-0-1",
    "After Meal 0-1-0",
    "After Meal 0-1-1",
    "After Meal 1-0-0",
    "After Meal 1-0-1",
    "After Meal 1-1-0",
    "After Meal 1-1-1",
    "Before Meal 0-0-1",
    "Before Meal 0-1-0",
    "Before Meal 0-1-1",
    "Before Meal 1-0-0",
    "Before Meal 1-0-1",
    "Before Meal 1-1-0",
    "Before Meal 1-1-1",
  ];
  List<Map<String, String>> medicinelist = [
    {
      "medicine_id": "1",
      "name": "Paracetamol",
      "description": "Pain reliever and fever reducer.",
      "price": "2.50",
    },
    {
      "medicine_id": "2",
      "name": "Amoxicillin",
      "description": "Antibiotic for bacterial infections.",
      "price": "8.75",
    },
    {
      "medicine_id": "3",
      "name": "Sitriction",
      "description": "Pain reliever and fever reducer.",
      "price": "2.50",
    },
    {
      "medicine_id": "4",
      "name": "Ibuprofen",
      "description": "Used to reduce fever and treat pain or inflammation.",
      "price": "3.20",
    },
    {
      "medicine_id": "5",
      "name": "Cetirizine",
      "description": "Antihistamine used for allergy relief.",
      "price": "1.80",
    },
    {
      "medicine_id": "6",
      "name": "Omeprazole",
      "description": "Used to treat acid reflux and stomach ulcers.",
      "price": "4.50",
    },
    {
      "medicine_id": "7",
      "name": "Azithromycin",
      "description": "Antibiotic used for various bacterial infections.",
      "price": "7.90",
    },
    {
      "medicine_id": "8",
      "name": "Metformin",
      "description": "Common medication for type 2 diabetes.",
      "price": "6.25",
    },
    {
      "medicine_id": "9",
      "name": "Amlodipine",
      "description": "Used to treat high blood pressure and chest pain.",
      "price": "3.75",
    },
    {
      "medicine_id": "10",
      "name": "Loratadine",
      "description": "Antihistamine used to relieve allergy symptoms.",
      "price": "2.10",
    },
    {
      "medicine_id": "11",
      "name": "Salbutamol",
      "description": "Used to relieve asthma and COPD symptoms.",
      "price": "5.00",
    },
    {
      "medicine_id": "12",
      "name": "Pantoprazole",
      "description": "Reduces stomach acid; used for GERD and ulcers.",
      "price": "4.00",
    },
    {
      "medicine_id": "13",
      "name": "Losartan",
      "description": "Treats high blood pressure and protects kidneys.",
      "price": "3.60",
    },
  ];

  List<Map<String, String>> selectedCombinations = [];

  String? selectedMedicine;
  String? selectedDosage;

  void addCombination() {
    if (selectedMedicine != null && selectedDosage != null) {
      setState(() {
        selectedCombinations.add({
          "medicine": selectedMedicine!,
          "dosage": selectedDosage!,
        });
      });
    }
  }

   generateMedicineOutput(List<Map<String, String>> selectedCombinations, List<Map<String, String>> medicineList) {
  List<Medicines>? output = [];

  for (var combination in selectedCombinations) {
    // Find the medicine name using the medicine_id
    print(combination["medicine"]);
    var medicine = medicineList.firstWhere(
      (m) => m["medicine_id"] == combination["medicine"],
      orElse: () => {"name": "Unknown"}
    );

 

     output.add(Medicines(medicineId:int.parse(combination["medicine"].toString(),),dosage: combination["dosage"],tabletLimit: 10));
  }

  return output;
}
DoctorBloc doctorBloc =DoctorBloc();
  Widget buildBloc() {
    return BlocConsumer<DoctorBloc, DoctorState>(
      bloc: doctorBloc,
      listener: (context, state) {
        if (state is AddprescriptionsLoadedState) {
          print('user reg loaded');
        
         navigateHomeScreen();
        }
      },
      builder: (BuildContext context, state) {
        if (state is AddprescriptionsLoadingState) {
          print('AddprescriptionsLoadedState loading');
        } else if (state is AddprescriptionsErrorState) {
          print('AddprescriptionsLoadedState error');
          return const SizedBox();
        } else if (state is AddprescriptionsLoadedState) {
          print('AddprescriptionsLoadedState');

          return const SizedBox();
        }
        return const SizedBox();
      },
    );
  }

    navigateHomeScreen(){
     Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          );
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<DoctorBloc>(create: (context) => DoctorBloc())],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Doctor'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
      
              // First TextField
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          top: 7,
                          left: 5,
                          right: 2,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Notes",
                          style: Theme.of(context).custom().textBody5_Dark_M,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 2),
                        child: Text(
                          "*",
                          style: Theme.of(context).custom().textBody2_Red_SB,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: notesTextEditingController,
                    showCursor: true,
                    style: Theme.of(context).custom().textBody5_Light_M,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      labelText: 'Enter Notes',
                      labelStyle: Theme.of(context).custom().textBody5_Light_M,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Constant.borderColorLight!,
                          width: 1,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Constant.borderErrorRed!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Constant.borderColorLight!,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      
              const SizedBox(height: 16),
              // Dropdown
              Column(
                children: [
                  // Dropdown for selecting medicine
                  DropdownButton<String>(
                    value: selectedMedicine,
                    hint: Text('Select Medicine'),
                    isExpanded: true,
                    items:
                        medicinelist.map((medicine) {
                          return DropdownMenuItem<String>(
                            value: medicine["medicine_id"],
                            child: Text(medicine["name"] ?? ''),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMedicine = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // Dropdown for selecting dosage
                  DropdownButton<String>(
                    value: selectedDosage,
                    hint: Text('Select Dosage'),
                    isExpanded: true,
                    items:
                        dosage.map((dosage) {
                          return DropdownMenuItem<String>(
                            value: dosage,
                            child: Text(dosage),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDosage = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: addCombination,
                    child: Text('Add Combination'),
                  ),
                  SizedBox(height: 20),
                  // List of selected combinations
                  Text('Added Combinations:'),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedCombinations.length,
                    itemBuilder: (context, index) {
                      final combination = selectedCombinations[index];
                      final medicine = medicinelist.firstWhere(
                        (element) =>
                            element["medicine_id"] == combination["medicine"],
                      );
                      return ListTile(
                        title: Text(
                          '${medicine["name"]} - ${combination["dosage"]}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              selectedCombinations.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
      
              const SizedBox(height: 24),
              buildBloc(),
      
              // Submit Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4C63B6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      // Handle form submission
      print(selectedCombinations);
                    List<Medicines>? medicine =  generateMedicineOutput(selectedCombinations,medicinelist);
                    print(medicine);
      
                      AddPrescriptionRequest addPrescriptionRequest=AddPrescriptionRequest(
                        patientId: int.parse(widget.doctorID.toString()),
                        notes: notesTextEditingController.text,
                        expiryDate: "2025-12-01",
                        medicines: medicine
                      );
      
                      print(jsonEncode(addPrescriptionRequest));

                      doctorBloc.add(AddPrescriptionEvent(addPrescriptionRequest));
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          bottom: false, // Prevent extra space at the bottom
          child: BottomNavigationBar(
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.indigo,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => VaccineFollowUpScreen()),
                    // );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VaccineFollowUpScreen(),
                      ),
                      (Route<dynamic> route) => route.isFirst,
                    );
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => HealthRecordsPage()),
                    // );
                  },
                  child: Icon(Icons.person),
                ),
                label: 'Records',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

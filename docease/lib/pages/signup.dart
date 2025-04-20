import 'dart:convert';

import 'package:docease_1/auth/auth_bloc.dart';
import 'package:docease_1/constant.dart';
import 'package:docease_1/model/doctor/doctor.dart';
import 'package:docease_1/model/patient/patient.dart';
import 'package:docease_1/pages/home.dart';
import 'package:docease_1/patient/patiemt_bloc.dart';
import 'package:docease_1/patient/patient_event.dart';
import 'package:docease_1/patient/patient_state.dart';
import 'package:docease_1/shared_prefrenec.dart';
import 'package:docease_1/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController dobTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController mobileTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? usernameErrorMessage;
  AuthBloc authBloc = AuthBloc();
  String? selectedValue = 'patient';

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

  String selectedName = 'Pediatrician';
  var selectedItem;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildpatientDoctorList();
  }

  Widget buildpatientDoctorList() {
    return BlocProvider(
      create: (context) => PatientBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Color(0xFFf3f5f5), width: 1),
          ),
          title: const Row(
            children: [
              Expanded(
                child: Text('Sign Up', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [buildsigninForm(), buildSaveButton()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 90,
        0,
        0,
        0,
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String busDateFormat(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    return formatted;
  }

  Widget buildsigninForm() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
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
                      "Name",
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
                controller: nameTextEditingController,
                showCursor: true,
                style: Theme.of(context).custom().textBody5_Light_M,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  labelText: 'Enter Name',
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
                    borderSide: BorderSide(color: Constant.borderColorLight!),
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
                      "User Name",
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
                controller: userNameTextEditingController,
                showCursor: true,
                style: Theme.of(context).custom().textBody5_Light_M,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  labelText: 'Enter User Name',
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
                    borderSide: BorderSide(color: Constant.borderColorLight!),
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
                      "Gender",
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
                controller: genderTextEditingController,
                showCursor: true,
                style: Theme.of(context).custom().textBody5_Light_M,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  labelText: 'Enter Gender',
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
                    borderSide: BorderSide(color: Constant.borderColorLight!),
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
                      "DOB",
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

              //         GestureDetector(
              //           onTap: () => _selectDate(context),
              //           child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 16.0),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.grey), // Border color
              //   borderRadius: BorderRadius.circular(8.0), // Rounded corners
              // ),
              //             child: RichText(
              //                     text: TextSpan(
              //                       children: [
              //                         TextSpan(
              //                             text: "${busDateFormat(selectedDate)} ",
              //                             style: const TextStyle(
              //                                 fontSize: 15.0,
              //                                 color: Colors.black)),

              //                       ],
              //                     ),
              //                   ),
              //           ),
              //         ),
              TextFormField(
                controller: dobTextEditingController,
                showCursor: true,
                style: Theme.of(context).custom().textBody5_Light_M,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  labelText: 'Enter Date of Birth',
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
                    borderSide: BorderSide(color: Constant.borderColorLight!),
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
                      "Mobile",
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
                controller: mobileTextEditingController,
                showCursor: true,
                style: Theme.of(context).custom().textBody5_Light_M,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  labelText: 'Enter Mobile Number',
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
                    borderSide: BorderSide(color: Constant.borderColorLight!),
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
                      "Email",
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
                controller: emailTextEditingController,
                showCursor: true,
                style: Theme.of(context).custom().textBody5_Light_M,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  labelText: 'Enter Email',
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
                    borderSide: BorderSide(color: Constant.borderColorLight!),
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
                      "Password",
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
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: passwordTextEditingController,
                  showCursor: true,
                  style: Theme.of(context).custom().textBody5_Light_M,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    labelText: 'Enter Password',
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
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 5, top: 7, left: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Role",
                  style: Theme.of(context).custom().textBody5_Dark_M,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Patient'),
                      leading: Radio<String>(
                        value: 'patient',
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Doctor'),
                      leading: Radio<String>(
                        value: 'doctor',
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          selectedValue=="doctor"? Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedName,
                  items:
                      specialty.map((item) {
                        return DropdownMenuItem<String>(
                          value: item["name"],
                          child: Text(item["name"] ?? ""),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedName = value!;
                    });
                
                    // Find and print the corresponding ID
                   
                  },
                ),
              ),
            ],
          ):SizedBox(),
        
        
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 5, top: 7, left: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Address",
                  style: Theme.of(context).custom().textBody5_Dark_M,
                ),
              ),
              Container(
                child: TextFormField(
                  controller: addressTextEditingController,
                  showCursor: true,
                  style: Theme.of(context).custom().textBody5_Light_M,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    labelText: 'Enter Address',
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
                      borderSide: BorderSide(color: Constant.borderColorLight!),
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildElevatedButtonMedium(
    btnText,
    btnTextColor,
    btnColor,
    btnBorderColor,
    Function? onPress,
  ) {
    return Visibility(
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(left: 10),
        child: ElevatedButton(
          onPressed: onPress as void Function()?,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(btnColor),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(width: 1, color: btnBorderColor),
              ),
            ),
          ),
          child: Center(
            child: Text(
              btnText,
              textAlign: TextAlign.center,
              style: TextStyle(color: btnTextColor, fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSaveButton() {
    return Column(
      children: [
        buildBloc(),
        buildElevatedButtonMedium(
          "Save",
          Constant.buttonNegativeOkColor,
          Constant.buttonColorDark,
          Constant.buttonColorDark,
          () async {
            if (selectedValue == 'patient') {
              if (nameTextEditingController.text.isEmpty) {
                _toast( "Please enter Name");
              } else if (userNameTextEditingController.text.isEmpty) {
                _toast( "Please enter User Name");
              } else if (emailTextEditingController.text.isEmpty) {
                _toast( "Please enter Email");
              } else if (passwordTextEditingController.text.isEmpty) {
                _toast( "Please enter Password");
              } else if (mobileTextEditingController.text.isEmpty) {
                _toast( "Please enter Mobile numer");
              } else if (dobTextEditingController.text.isEmpty) {
                _toast( "Please enter Date of Birth");
              } else if (genderTextEditingController.text.isEmpty &&
                  (genderTextEditingController.text.trim() == "male" ||
                      genderTextEditingController.text.trim() == "female")) {
                _toast( "Please enter valid Gender");
              } else if (addressTextEditingController.text.isEmpty) {
                _toast( "Please enter Address");
              } else {
                PatientRegisterRequest patientRegisterRequest =
                    PatientRegisterRequest(
                      name: nameTextEditingController.text,
                      userName: userNameTextEditingController.text,
                      password: passwordTextEditingController.text,
                      gender: genderTextEditingController.text,
                      dob: dobTextEditingController.text,
                      mobileNumber: mobileTextEditingController.text,
                      email: emailTextEditingController.text,
                      role: selectedValue,
                      address: addressTextEditingController.text,
                      deviceToken: "",
                    );
                print(jsonEncode(patientRegisterRequest));

                patientBloc.add(
                  PatientRegEvent(
                    patientRegisterRequest: patientRegisterRequest,
                  ),
                );
              }
            } else {
              if (nameTextEditingController.text.isEmpty) {

                  _toast( "Please enter Name");
              } else if (userNameTextEditingController.text.isEmpty) {
                _toast( "Please enter User Name");
              } else if (emailTextEditingController.text.isEmpty) {
                _toast( "Please enter Email");
              } else if (passwordTextEditingController.text.isEmpty) {
                _toast( "Please enter Password");
              } else if (mobileTextEditingController.text.isEmpty) {
                _toast( "Please enter Mobile numer");
              } else if (dobTextEditingController.text.isEmpty) {
                _toast( "Please enter Date of Birth");
              } else if (genderTextEditingController.text.isEmpty &&
                  (genderTextEditingController.text.trim() == "male" ||
                      genderTextEditingController.text.trim() == "female")) {
                _toast( "Please enter valid Gender");
              } else if (addressTextEditingController.text.isEmpty) {
                _toast( "Please enter Address");
              } else {
               selectedItem =
                        specialty.firstWhere((item) => item["name"] == selectedName);
                    print("Selected ID: ${selectedItem["id"]}");
              DoctorRegReq doctorRegReq = DoctorRegReq(
                name: nameTextEditingController.text,
                userName: userNameTextEditingController.text,
                password: passwordTextEditingController.text,
                gender: genderTextEditingController.text,
                dob: dobTextEditingController.text,
                mobileNumber: mobileTextEditingController.text,
                email: emailTextEditingController.text,
                role: selectedValue,
                address: addressTextEditingController.text,
                deviceToken: "",
                specialist: int.parse(selectedItem["id"]),
              );

              print(jsonEncode(doctorRegReq));


                patientBloc.add(
                  PatientRegEvent(
                    patientRegisterRequest: doctorRegReq,
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }

  _toast(msg){
     Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red.shade400,
            textColor: Colors.white,
            fontSize: 12.0,
          );
  }

  PatientBloc patientBloc = PatientBloc();
  Widget buildBloc() {
    return BlocBuilder<PatientBloc, PatientState>(
      bloc: patientBloc,
      builder: (BuildContext context, state) {
        if (state is PatientRegLoadingState) {
          print('user loading');
        } else if (state is PatientRegErrorState) {
          print('UserReg error');
          _toast(state.error);
          return const SizedBox();
        } else if (state is PatientRegLoadedState) {
          print('user reg loaded');
          SharedPreference.login(
            authToken: state.authResponse![0].accessToken.toString(),
            sessionId: state.authResponse![0].sessionToken.toString(),
            userNmae: userNameTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim(),
          );
         navigateHomeScreen();
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

  String calculateSeatAvailabilityPercentage(
    int bookedSeatCount,
    int totalSeatCount,
  ) {
    double per = ((bookedSeatCount / totalSeatCount) * 100);
    return (!per.isInfinite) && per > 0 ? "(${per.toStringAsFixed(2)}%)" : "";
  }
}

void _toast(BuildContext context, String errDesc) async {
  await Future.delayed(const Duration(microseconds: 1));
  if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
    FocusScope.of(context).requestFocus(FocusNode());
    Fluttertoast.showToast(msg: errDesc);
  }
}

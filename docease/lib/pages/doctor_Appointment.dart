import 'package:docease_1/doctor/doctor_bloc.dart';
import 'package:docease_1/doctor/doctor_event.dart';
import 'package:docease_1/doctor/doctor_state.dart';
import 'package:docease_1/model/doctor/doctor.dart';
import 'package:docease_1/pages/home.dart';
import 'package:docease_1/pages/record.dart';
import 'package:docease_1/pages/schedule_Appointment.dart';
import 'package:docease_1/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentPage extends StatefulWidget {
  final String doctorName;
  final String doctorId;
  final String doctorSpecialist;

  const DoctorAppointmentPage({
    super.key,
    required this.doctorName,
    required this.doctorId,
    required this.doctorSpecialist,
  });

  @override
  State<DoctorAppointmentPage> createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  int _selectedDayIndex = 2; // Default selected day (Tuesday)
  int? _selectedTimeIndex; // No time selected by default

  final List<String> _days = ["Sun", "Mon", "Tue", "Wed", "Thu"];
  final List<String> _dates = ["3", "4", "5", "6", "7"];
  final List<String> _timeSlots = [
    "9:00 AM - 10:00 AM",
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM",
    "3:00 PM - 4:00 PM",
  ];
  DateTime? dateTime;
  String formatted = "";
  String showFormated = '';
  DoctorBloc doctorBloc = DoctorBloc();
  buildListernerDoctor(context, state) {
    if (state is SchedleAppointmentLoadingState) {
      print("SchedleAppointmentLoadingState");
    } else if (state is SchedleAppointmentLoadedState) {
      print("SchedleAppointmentLoadedState");
      state.scheduleAppointmentResData;
      _confirmAppointment();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<DoctorBloc>(create: (context) => DoctorBloc())],
      child: BlocConsumer<DoctorBloc, DoctorState>(
        bloc: doctorBloc,
        listener: (BuildContext context, DoctorState state) {
          buildListernerDoctor(context, state);
        },
        builder: (context, DoctorState state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("Book Appointment"),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Image.asset(
                            'lib/assets/images/doctor.png',
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4C63B6),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.doctorName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${widget.doctorSpecialist}",
                                style: TextStyle(color: Colors.white70),
                              ),
                              Text(
                                "Hindu Mission Hospital",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      "Appointment",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DatePicker(
                      DateTime.now(),
                      dateTextStyle: TextStyle(fontSize: 14),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Color(0xFF4C63B6),
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        // New date selected
                        setState(() {
                          dateTime = date;
                          print(dateTime);
                          DateTime updated = dateTime!.copyWith(
                            hour: 10,
                            minute: 30,
                          );
                          formatted = DateFormat(
                            "yyyy-MM-dd HH:mm:ss",
                          ).format(updated);
                          print(formatted); // Output: 2025-04-20 10:30:00
                          showFormated = DateFormat(
                            "dd-MM-yyyy",
                          ).format(updated);
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            ScheduleAppointmentReq scheduleAppointmentReq =
                                ScheduleAppointmentReq(
                                  status: "scheduled",
                                  doctorId: int.parse(widget.doctorId),
                                  problemDescription: "New appointment",
                                  appointmentDate: formatted,
                                );
                            doctorBloc.add(
                              ScheduleAppointmentEvent(scheduleAppointmentReq),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4C63B6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            disabledBackgroundColor: Color(0xFF4C63B6),
                          ),
                          child: const Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              bottom: false,
              child: BottomNavigationBar(
                currentIndex: 1, // Highlight appointments tab
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.indigo,
                unselectedItemColor: Colors.grey,
                items: [
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap:
                          () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                            (route) => route.isFirst,
                          ),
                      child: const Icon(Icons.home),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.calendar_month),
                    label: 'Appointments',
                  ),
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap:
                          () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HealthRecordsPage(),
                            ),
                            (route) => route.isFirst,
                          ),
                      child: const Icon(Icons.person),
                    ),
                    label: 'Records',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmAppointment() {
    // Handle appointment confirmation logic
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Appointment Confirmed"),
            content: Text(
              "Your appointment with ${widget.doctorName} on ${showFormated} has been confirmed.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); 
                  Navigator.pop(context); // Go back to previous screen
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  Widget _dayItem(String day, String date, {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFD6E6FF) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          if (selected)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        children: [
          Text(day, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(date, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _timeChip(String time, {bool selected = false}) {
    return Chip(
      label: Text(time),
      backgroundColor: selected ? Colors.orange[100] : Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: selected ? Colors.orange[900] : Colors.black,
      ),
    );
  }
}

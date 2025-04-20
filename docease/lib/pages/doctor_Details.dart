
import 'package:docease_1/doctor/doctor_bloc.dart';
import 'package:docease_1/pages/doctor_Appointment.dart';
import 'package:docease_1/pages/record.dart';
import 'package:docease_1/pages/schedule_Appointment.dart';
import 'package:flutter/material.dart';


class DoctorProfilePage extends StatefulWidget {
 final String doctorName;
  final String designation;
  final String imagePath;
  final double rating;
  final int reviews;
  final int patients;
  final int years;
  final int totalReviews;
  final String about;
  final String doctorID;

  const DoctorProfilePage({
    super.key,
    required this.doctorName,
    required this.designation,
    required this.imagePath,
    required this.rating,
    required this.reviews,
    required this.patients,
    required this.years,
    required this.doctorID,
    required this.totalReviews,
    required this.about,
  });

  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  TextEditingController userNameTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DoctorBloc doctorBloc = DoctorBloc();
  @override
  void initState() {
    super.initState();
  }

   Widget _infoTile(IconData icon, String count, String label) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.indigo),
        const SizedBox(height: 4),
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Stack(
              children: [
                SizedBox(
                  height: 235, // You can adjust the height as needed
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(widget.imagePath, fit: BoxFit.contain),
                  ),
                ),
                // Positioned(
                //   top: 10,
                //   right: 10,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: Colors.white,
                //     ),
                //     padding: const EdgeInsets.all(8),
                //     child: const Icon(Icons.favorite_border, color: Colors.red),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.doctorName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(widget.designation, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Row(
              children: [
                // const Icon(Icons.star, color: Colors.amber, size: 20),
                Text(
                  "Hindu Mission Hospital",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoTile(Icons.person, "${widget.patients}+", 'Patients'),
                _infoTile(Icons.badge, "${widget.years}+", 'Years'),
                // _infoTile(Icons.star_half, "$rating", 'Rating'),
                _infoTile(Icons.reviews, "${widget.totalReviews}+", 'Reviews'),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'About Me',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.about,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorAppointmentPage(doctorId: widget.doctorID,doctorName: widget.doctorName,doctorSpecialist:widget.designation ,),
                      ),
                    );
                  },
                  child: const Text(
                    'Book Appointment',
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
  MaterialPageRoute(builder: (context) => VaccineFollowUpScreen()),
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
  MaterialPageRoute(builder: (context) => HealthRecordsPage()),
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
    );
 
        
          
      
     
    
  }
}

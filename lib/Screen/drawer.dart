import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/Admin/student.dart';
import 'package:sporthall_booking_system/Screen/Booking/booking.dart';
import 'package:sporthall_booking_system/Screen/Booking/student_record.dart';
import 'package:sporthall_booking_system/Screen/Homepage/home.dart';
import 'UserProfile/profile.dart';

//import '../Login/login_screen.dart';

class SideDrawer extends StatelessWidget {
  // final User user = await FirebaseAuth.instance.currentUser.email == null;
  // final userid = user.userid;
  String email = FirebaseAuth.instance.currentUser.email == null
      ? FirebaseAuth.instance.currentUser.phoneNumber
      : FirebaseAuth.instance.currentUser.email;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'ScoreLah',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade800, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.account_circle_sharp),
              title: Text('Hello $email'),
              onTap: () {
                var firebaseUser = FirebaseAuth.instance.currentUser;
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(firebaseUser.uid)
                    .get()
                    .then((value) {
                  print(value.data().length);
                });
              },
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Dashboard'),
                onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      ),
                    }),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Add Student'),
              onTap: () => {
                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => BookingHistory()),
                  MaterialPageRoute(builder: (context) => Booking()),
                ),
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.receipt_rounded),
              title: Text('Student Record'),
              onTap: () => {
                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => BookingHistory()),
                  MaterialPageRoute(builder: (context) => StudentRecord()),
                ),
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.accessible_rounded),
              title: Text('Student List'),
              onTap: () => {
                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => BookingHistory()),
                  MaterialPageRoute(builder: (context) => studentBody()),
                ),
              },
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(Icons.assignment_ind_outlined),
                title: Text('View Profile'),
                onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      ),
                    }),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //       left: 60.0, right: 60.0, top: 300, bottom: 40),
          //   child: Expanded(
          //     child: Align(
          //       alignment: Alignment.bottomCenter,
          //       child: FloatingActionButton(
          //         onPressed: () => {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => LoginPage()),
          //           ),
          //         },
          //         child: const Icon(Icons.logout),
          //         backgroundColor: Colors.red,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

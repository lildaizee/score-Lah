import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Model/UserModel.dart';
import 'package:sporthall_booking_system/Screen/Admin/StatusScreen.dart';
import 'package:sporthall_booking_system/Screen/Booking/booking.dart';
import 'package:sporthall_booking_system/Screen/Booking/display_student.dart';
import 'package:sporthall_booking_system/Screen/Homepage/home.dart';
import 'package:sporthall_booking_system/Screen/Student/AddStudent.dart';
import 'package:sporthall_booking_system/providers/AuthServiceProvider.dart';

import 'UserProfile/profile.dart';

//import '../Login/login_screen.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel user = context.watch<AuthServiceProvider>().getUserData;
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
              title: Text('Hello ' + user.fullname ?? ''),
              onTap: () {
                var firebaseUser = FirebaseAuth.instance.currentUser;
                FirebaseFirestore.instance.collection("Users").doc(firebaseUser.uid).get().then((value) {
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
          user == null
              ? SizedBox()
              : user.userType == 'Parent'
                  ? SizedBox()
                  : Card(
                      child: ListTile(
                        leading: Icon(Icons.account_box),
                        title: Text('Add Student'),
                        onTap: () => {
                          Navigator.pushReplacement(
                            context,
                            //MaterialPageRoute(builder: (context) => BookingHistory()),
                            MaterialPageRoute(builder: (context) => AddStudent()),
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
                  MaterialPageRoute(builder: (context) => DisplayStudent()),
                ),
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.receipt_rounded),
              title: Text('View Status'),
              onTap: () => {
                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => BookingHistory()),
                  MaterialPageRoute(builder: (context) => StatusScreen()),
                ),
              },
            ),
          ),
          // Card(
          //   child: ListTile(
          //     leading: Icon(Icons.accessible_rounded),
          //     title: Text('Student List'),
          //     onTap: () => {
          //       Navigator.push(
          //         context,
          //         //MaterialPageRoute(builder: (context) => BookingHistory()),
          //         MaterialPageRoute(builder: (context) => studentBody()),
          //       ),
          //     },
          //   ),
          // ),
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
          // Card(
          //   child: ListTile(
          //       leading: Icon(Icons.assignment_ind_outlined),
          //       title: Text('Update Status'),
          //       onTap: () => {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(builder: (context) => Booking()),
          //             ),
          //           }),
          // ),
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

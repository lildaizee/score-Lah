import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Model/collegeCourtBooking.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Services/Database.dart';
import 'collegeCourtBookingList.dart';

class collegeCourtBody extends StatefulWidget {
  @override
  _collegeCourtState createState() => _collegeCourtState();
}

class _collegeCourtState extends State<collegeCourtBody> {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return StreamProvider<List<CollegeCourtBooking>>.value(
        value: DatabaseService().collegeCourt,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('College Court Booking'),
            backgroundColor: Colors.blue,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    //sign Out User
                    AuthClass().signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  })
            ],
          ),
          body: collegeCourtList(),
        ));
  }
}

// ignore_for_file: missing_required_param

import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/Admin/sporthallBookingList.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';
import 'package:sporthall_booking_system/Model/sporthallBooking.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Services/Database.dart';

class SporthallBody extends StatefulWidget {
  @override
  _SporthallBodyState createState() => _SporthallBodyState();
}

class _SporthallBodyState extends State<SporthallBody> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<SporthallBooking>>.value(
        value: DatabaseService().sporthall,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Sporthall Booking'),
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
          body: SporthallList(),
        ));
  }
}

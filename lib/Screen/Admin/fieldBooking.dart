import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/Admin/fieldBookingList.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';
import 'package:sporthall_booking_system/Model/FieldBooking.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Services/Database.dart';

class FieldBody extends StatefulWidget {
  @override
  _FieldBodyState createState() => _FieldBodyState();
}

class _FieldBodyState extends State<FieldBody> {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return StreamProvider<List<FieldBooking>>.value(
        value: DatabaseService().field,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Field Booking'),
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
          body: FieldList(),
        ));
  }
}

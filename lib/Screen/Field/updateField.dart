import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/Field/updateField_body.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import 'package:sporthall_booking_system/Screen/drawer.dart';

class UpdateField extends StatefulWidget {
  @override
  _UpdateFieldState createState() => _UpdateFieldState();
}

class _UpdateFieldState extends State<UpdateField> {
  String user = FirebaseAuth.instance.currentUser.email == null
      ? FirebaseAuth.instance.currentUser.phoneNumber
      : FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Field Booking"),
        actions: [
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
      body: UpdateFieldBooking(),
      drawer: SideDrawer(),
    );
  }
}

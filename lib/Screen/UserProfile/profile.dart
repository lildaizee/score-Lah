import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/UserProfile/profile_body.dart';
import 'package:sporthall_booking_system/Screen/widgets/app_bar.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import '../drawer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'User Profile'),
      body: ProfileBody(),
      drawer: SideDrawer(),
    );
  }
}

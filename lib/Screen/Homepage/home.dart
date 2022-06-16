import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/widgets/app_bar.dart';

import '../drawer.dart';
import 'home_body.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String user = FirebaseAuth.instance.currentUser.email == null
      ? FirebaseAuth.instance.currentUser.phoneNumber
      : FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ScoreLah'),
      body: Dashboard(),
      drawer: SideDrawer(),
    );
  }
}

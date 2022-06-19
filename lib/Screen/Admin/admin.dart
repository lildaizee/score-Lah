import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import 'package:sporthall_booking_system/Screen/drawer.dart';
import 'package:sporthall_booking_system/Screen/widgets/app_bar.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';

import 'admin_body.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // String user = FirebaseAuth.instance.currentUser.email == null
  //     ? FirebaseAuth.instance.currentUser.phoneNumber
  //     : FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Admin Dashboard'),
      drawer: SideDrawer(),
      body: AdminBody(),
    );
  }
}

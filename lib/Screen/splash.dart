import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sporthall_booking_system/Model/UserModel.dart';
import 'package:sporthall_booking_system/Screen/Admin/admin.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import 'package:sporthall_booking_system/Screen/Homepage/home.dart';
import 'package:sporthall_booking_system/providers/AuthServiceProvider.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    UserModel user = context.watch<AuthServiceProvider>().getUserData;
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: context.read<AuthServiceProvider>().getCurrentUserAuth == null
            ? LoginPage()
            : user != null && user.userType == 'Parent'
                ? HomePage()
                : AdminPage(),
        title: new Text(
          'Welcome to \n ScoreLah Application',
          textAlign: TextAlign.center,
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.blueGrey[600]),
        ),
        image: new Image.asset('assets/images/Logo.png', height: 400, width: 350, scale: 1.0),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 80.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.blue);
  }
}

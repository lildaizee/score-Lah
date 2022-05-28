import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Model/Student.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Services/Database.dart';
import 'studentList.dart';

class studentBody extends StatefulWidget {
  @override
  _studentState createState() => _studentState();
}

class _studentState extends State<studentBody> {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return StreamProvider<List<Student>>.value(
        value: DatabaseService().studentsList,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Student'),
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
          body: studentList(),
        ));
  }
}

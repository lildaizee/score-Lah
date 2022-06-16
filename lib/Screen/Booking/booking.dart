// ignore_for_file: unused_label

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import 'package:sporthall_booking_system/Screen/drawer.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';
import 'booking_record.dart';
import 'package:sporthall_booking_system/Model/Student.dart';
//import 'package:sporthall_booking_system/Models/auth_provider.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerClassroom = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
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
            },
          ),
        ],
      ),
      // body: BookingRecord(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: InputDecoration(
              hintText: 'Name',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllerAge,
            decoration: InputDecoration(
              hintText: 'Age',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllerClassroom,
            decoration: InputDecoration(
              hintText: 'Class',
              border: OutlineInputBorder(),
            ),
            //keyboardType: TextInputType.numberWithOptions(),
          ),
          const SizedBox(height: 24),
          const SizedBox(height: 32),
          ElevatedButton(
              onPressed: () {
                final student = Student(
                  name: controllerName.text,
                  age: controllerAge.text,
                  classroom: controllerClassroom.text,
                );

                createUser(student);
                Navigator.pop(context);
              },
              child: Text('Create')),
        ],
      ),
      drawer: SideDrawer(),
    );
  }

  Future createUser(Student student) async {
    final docUser = FirebaseFirestore.instance.collection('Student').doc();
    student.id = docUser.id;
    final json = student.toJson();

    await docUser.set(json);
  }
}

// class Student {
//   String id;
//   final String name;
//   final String age;
//   final String classroom;

//   Student({
//     this.id = '',
//     this.name,
//     this.age,
//     this.classroom,
//   });

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'age': age,
//         'classroom': classroom,
//       };
// }

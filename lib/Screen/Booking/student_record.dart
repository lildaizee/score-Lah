// ignore_for_file: unused_label

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import 'package:sporthall_booking_system/Screen/Booking/booking.dart';
import 'package:sporthall_booking_system/Screen/drawer.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';
import 'booking.dart';
import 'package:sporthall_booking_system/database.dart';

class StudentRecord extends StatefulWidget {
  @override
  _StudentRecordState createState() => _StudentRecordState();
}

class _StudentRecordState extends State<StudentRecord> {
  final Stream<QuerySnapshot> student =
      FirebaseFirestore.instance.collection('Student').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Record"),
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
      body: FutureBuilder<Student?>(
        future: readUser(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            final user = snapshot.data;
            return student == null
            ? Center(child: Text('No Student')): buildUser(student);
          }
        },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Booking()),
          ),
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
      drawer: SideDrawer(),
    );
  }
}

Future<Student?> readUser() async{
  final docUser = FirebaseFirestore.instance.collection('Student').doc('my-id');
  final snapshot = await docUser.get();

  if(snapshot.exists){
    return Student.fromJson(snapshot.data()!);
  }
}

import 'package:flutter/material.dart';
//import 'package:sporthall_booking_system/Screen/Admin/CollegeCourtBookingTile.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Model/Student.dart';
import 'package:sporthall_booking_system/Screen/Admin/studentTile.dart';

class studentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<studentList> {
  get students => null;
  @override
  Widget build(BuildContext context) {
    final studentlist = Provider.of<List<Student>>(context);
    if (studentlist == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: studentlist.length,
        itemBuilder: (context, index) {
          if (index != null) {
            return StudentTile(student: students[index]);
          }
        },
      );
    }
  }
}

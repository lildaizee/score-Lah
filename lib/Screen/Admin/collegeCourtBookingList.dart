import 'package:flutter/material.dart';
//import 'package:sporthall_booking_system/Screen/Admin/CollegeCourtBookingTile.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Model/CollegeCourtBooking.dart';
import 'package:sporthall_booking_system/Screen/Admin/collegeCourtBookingTile.dart';

class collegeCourtList extends StatefulWidget {
  @override
  _CollegeCourtListState createState() => _CollegeCourtListState();
}

class _CollegeCourtListState extends State<collegeCourtList> {
  get collegeCourts => null;
  @override
  Widget build(BuildContext context) {
    final collegeCourt = Provider.of<List<CollegeCourtBooking>>(context);
    if (collegeCourt == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: collegeCourt.length,
        itemBuilder: (context, index) {
          return CollegeCourtTile(collegeCourt: collegeCourts[index]);
        },
      );
    }
  }
}

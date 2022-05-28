//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/Admin/SporthallBookingTile.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Model/SporthallBooking.dart';

class SporthallList extends StatefulWidget {
  @override
  _SporthallListState createState() => _SporthallListState();
}

class _SporthallListState extends State<SporthallList> {
  get sporthalls => null;
  @override
  Widget build(BuildContext context) {
    final sporthall = Provider.of<List<SporthallBooking>>(context);
    if (sporthall == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: sporthall.length,
        itemBuilder: (context, index) {
          return SporthallTile(sporthall: sporthalls[index]);
        },
      );
    }
  }
}

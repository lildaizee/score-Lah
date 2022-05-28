//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/Admin/fieldBookingTile.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Model/fieldBooking.dart';

class FieldList extends StatefulWidget {
  @override
  _FieldListState createState() => _FieldListState();
}

class _FieldListState extends State<FieldList> {
  get fields => null;

  @override
  Widget build(BuildContext context) {
    final field = Provider.of<List<FieldBooking>>(context);
    if (field == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: field.length,
        itemBuilder: (context, index) {
          return FieldTile(field: fields[index]);
        },
      );
    }
  }
}

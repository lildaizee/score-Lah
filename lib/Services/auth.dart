import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/UserProfile/profile_body.dart';
import 'package:sporthall_booking_system/Screen/Booking/booking_record.dart';

class Management {
  getUser(user, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser.uid)
        .set({
          'fullname': user.fullname,
          'username': user.username,
          'contact': user.contact
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileBody())))
        .catchError((e) {
          print(e);
        });
  }

  getSporthallBooking(bookingSporthall, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('BookingSporthall')
        .doc(firebaseUser.uid)
        .set({
          'selectedBookingdate': bookingSporthall.selectedBookingdate,
          'selectedHall': bookingSporthall.selectedHall,
          'selectedSlot': bookingSporthall.selectedSlot
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => BookingRecord())))
        .catchError((e) {
          print(e);
        });
  }

  getCollegeCourtBooking(bookingCollegeCourt, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('BookingCollegeCourt')
        .doc(firebaseUser.uid)
        .set({
          'selectedBookingdate': bookingCollegeCourt.selectedBookingdate,
          'selectedCourt': bookingCollegeCourt.selectedCourt,
          'selectedSlot': bookingCollegeCourt.selectedSlot
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => BookingRecord())))
        .catchError((e) {
          print(e);
        });
  }

  getFieldBooking(bookingField, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('BookingField')
        .doc(firebaseUser.uid)
        .set({
          'selectedBookingdate': bookingField.selectedBookingdate,
          'selectedField': bookingField.selectedField,
          'selectedSlot': bookingField.selectedSlot
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => BookingRecord())))
        .catchError((e) {
          print(e);
        });
  }
}

// ignore_for_file: unused_element, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporthall_booking_system/Model/FieldBooking.dart';
import 'package:sporthall_booking_system/Model/Profile.dart';
import 'package:sporthall_booking_system/Model/Student.dart';
import 'package:sporthall_booking_system/Model/Users.dart';
import 'package:sporthall_booking_system/Model/collegeCourtBooking.dart';
import 'package:sporthall_booking_system/Model/sporthallBooking.dart';
// ignore: unused_import
import 'package:sporthall_booking_system/Screen/Admin/collegeCourtBooking.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  List<UserData> users = [];
  //final CollectionReference user = Firestore.instance.collection("User");
  final CollectionReference userProfile = FirebaseFirestore.instance.collection('Users');

  final CollectionReference sporthallList = FirebaseFirestore.instance.collection('Sporthall');

  final CollectionReference sporthallHistory = FirebaseFirestore.instance.collection('BookingSporthall');

  final CollectionReference collegeCourtHistory = FirebaseFirestore.instance.collection('BookingCollegeCourt');

  final CollectionReference FieldHistory = FirebaseFirestore.instance.collection('BookingField');

  final CollectionReference students = FirebaseFirestore.instance.collection('Student');

  final CollectionReference status = FirebaseFirestore.instance.collection('Status');

  Future updateUserData(String fullname, String username, String contact, String usertype, String email, String uid) async {
    return await userProfile.doc(uid).set({
      'uid': uid,
      'fullname': fullname,
      'username': username,
      'contact': contact,
      'userType': usertype,
      'email': email,
    });
  }

  List<Profile> _profileListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Profile(username: doc.data()['username'] ?? '', fullname: doc.data()['fullname'] ?? '', contact: doc.data()['contact'] ?? '');
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid, fullname: snapshot.data()['fullname'], username: snapshot.data()['username'], contact: snapshot.data()['contact']);
  }

  Stream<List<Profile>> get profile {
    return userProfile.snapshots().map(_profileListFromSnapshot);
  }

  //Sporthall booking list
  List<SporthallBooking> _sporthallListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SporthallBooking(selectedHall: doc.data()['selectedHall'] ?? '', selectedBookingdate: doc.data()['selectedBookingdate'] ?? '', selectedSlot: doc.data()['selectedSlot'] ?? '');
    }).toList();
  }

  Stream<List<SporthallBooking>> get sporthall {
    return sporthallHistory.snapshots().map(_sporthallListFromSnapshot);
  }

  //College court booking list
  List<CollegeCourtBooking> _collegeCourtListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CollegeCourtBooking(selectedCourt: doc.data()['selectedCourt'] ?? '', selectedBookingdate: doc.data()['selectedBookingdate'] ?? '', selectedSlot: doc.data()['selectedSlot'] ?? '');
    }).toList();
  }

  Stream<List<CollegeCourtBooking>> get collegeCourt {
    return collegeCourtHistory.snapshots().map(_collegeCourtListFromSnapshot);
  }

  //Field booking list
  List<FieldBooking> _fieldListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FieldBooking(selectedField: doc.data()['selectedField'] ?? '', selectedBookingdate: doc.data()['selectedBookingdate'] ?? '', selectedSlot: doc.data()['selectedSlot'] ?? '');
    }).toList();
  }

  Stream<List<FieldBooking>> get field {
    return FieldHistory.snapshots().map(_fieldListFromSnapshot);
  }

  //Student list
  List<Student> _studentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Student(name: doc.data()['name'] ?? '', age: doc.data()['age'] ?? '', classroom: doc.data()['classroom'] ?? '');
    }).toList();
  }

  Stream<List<Student>> get studentsList {
    return students.snapshots().map(_studentListFromSnapshot);
  }

  Future<DocumentSnapshot> getUserData() async {
    final DocumentSnapshot doc = await userProfile.doc(uid).get();
    return doc;
  }

  Future<String> getSporthallCount() async {
    var length = 0;
    await FirebaseFirestore.instance.collection('Sporthall').get().then((myDocuments) {
      print("${myDocuments.docs.length}");
      length = myDocuments.docs.length;
    });
    return Future.value(length.toString());
  }
}

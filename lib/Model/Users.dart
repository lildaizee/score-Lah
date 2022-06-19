import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String userid;
  Users({this.userid});
}

class UserData {
  final String uid;
  final String fullname;
  final String username;
  final String contact;
  final String userType;
  final String email;

  UserData({this.email, this.userType, this.uid, this.fullname, this.username, this.contact});

  factory UserData.fromDatabase(Map<String, dynamic> data) {
    return UserData(
      uid: data['userid'],
      fullname: data['fullname'],
      username: data['username'],
      contact: data['contact'],
      userType: data['userType'],
      email: data['email'],
    );
  }

  UserData userFromFirebase(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.id,
      fullname: snapshot.get('fullname'),
      username: snapshot.get('username'),
      contact: snapshot.get('contact'),
      userType: snapshot.get('userType'),
      email: snapshot.get('email'),
    );
  }

  Map<String, dynamic> toDatabase() {
    return {'uid': uid, 'fullname': fullname, 'username': username, 'contact': contact};
  }

  String getUid() {
    return uid;
  }

  String getUsername() {
    return username;
  }
}

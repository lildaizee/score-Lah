// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.uid,
    this.fullname,
    this.username,
    this.email,
    this.contact,
    this.userType,
  });

  String uid;
  String fullname;
  String username;
  String email;
  String contact;
  String userType;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        fullname: json["fullname"],
        username: json["username"],
        email: json["email"],
        contact: json["contact"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "username": username,
        "email": email,
        "contact": contact,
        "userType": userType,
      };

  UserModel fromFirebase(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.id,
      fullname: doc.get("fullname"),
      username: doc.get('username'),
      email: doc.get('email'),
      contact: doc.get('contact'),
      userType: doc.get('userType'),
    );
  }
}

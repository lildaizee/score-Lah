import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

StatusModel statusModelFromJson(String str) => StatusModel.fromJson(json.decode(str));

String statusModelToJson(StatusModel data) => json.encode(data.toJson());

class StatusModel {
  StatusModel({
    this.statusID,
    this.uploaderID,
    this.picture,
    this.comments,
    this.caption,
  });

  String uploaderID;
  String statusID;
  String caption;
  List<String> picture;
  List<Comment> comments;

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        uploaderID: json["uploaderID"],
        picture: json["picture"],
        caption: json["caption"],
        statusID: json["statusID"],
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusID": statusID,
        "uploaderID": uploaderID,
        "picture": picture,
        "caption": caption,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };

  StatusModel fromFirebaseQuery(QueryDocumentSnapshot snapshot) {
    // List<Comment> comments = snapshot.get('comments').map((e) {
    //   return Comment(
    //     uid: e['uid'],
    //     fullname: e['fullname'],
    //     comment: e['comment'],
    //     timeCreated: e['timeCreated'],
    //   );
    // }).toList();
    // Map<String, dynamic> commentSnapshot = Map<String, dynamic>.from(snapshot.get('comments') ?? {});
    // List<Comment> comments = commentSnapshot.values.map((e) => Comment.commentFromMap(e)).toList();

    try {
      return StatusModel(
        uploaderID: snapshot.get('uploaderID'),
        statusID: snapshot.get('statusID'),
        picture: List<String>.from(snapshot.get('picture').map((e) => e)),
        caption: snapshot.get('caption'),
        comments: List<Comment>.from(snapshot.get('comments').map((e) => Comment.commentFromMap(e))) ?? [],
      );
    } catch (e) {
      throw ("$e");
    }
  }
}

class Comment {
  Comment({
    this.uid,
    this.fullname,
    this.timeCreated,
    this.comment,
  });

  String uid;
  String fullname;
  String timeCreated;
  String comment;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        uid: json["uid"],
        fullname: json["fullname"],
        timeCreated: json["timeCreated"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "timeCreated": timeCreated,
        "comment": comment,
      };

  static Comment commentFromMap(Map<String, dynamic> map) {
    DateTime now = DateTime.parse(map['timeCreated']);
    try {
      return Comment(
        uid: map['uid'],
        fullname: map['fullname'],
        timeCreated: timeago.format(now),
        comment: map['comment'],
      );
    } catch (e) {
      throw ("$e");
    }
  }
}

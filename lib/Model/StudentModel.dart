import 'dart:convert';

StudentModel studentModelFromJson(String str) => StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel({
    this.uid,
    this.fullname,
    this.age,
    this.classroom,
  });

  String uid;
  String fullname;
  String age;
  String classroom;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        uid: json["uid"],
        fullname: json["fullname"],
        age: json["age"],
        classroom: json["classroom"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "age": age,
        "classroom": classroom,
      };
}

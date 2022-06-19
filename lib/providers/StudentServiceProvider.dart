import 'package:flutter/cupertino.dart';
import 'package:sporthall_booking_system/Model/StudentModel.dart';
import 'package:sporthall_booking_system/Services/Database.dart';

class StudentServiceProvider extends ChangeNotifier {
  //create new Student
  initialize() {}

  Future<bool> createNewStudent(StudentModel studentModel) async {
    try {
      final docref = DatabaseService().students.doc();
      studentModel.uid = docref.id;
      docref.set(studentModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<StudentModel>> getListStudent() {
    return DatabaseService().students.snapshots().map((event) {
      return event.docs.map((e) {
        return StudentModel(
          fullname: e.get('fullname') ?? '',
          age: e.get('age') ?? '',
          classroom: e.get('classroom') ?? '',
          uid: e.get('uid'),
        );
      }).toList();
    });
  }

  Stream<List<StudentModel>> getStudents(String age) {
    return DatabaseService().students.snapshots().map((event) {
      return event.docs
          .where((element) {
            return element.get('age') == age;
          })
          .map((e) => StudentModel(
                fullname: e.get('fullname') ?? '',
                age: e.get('age') ?? '',
                classroom: e.get('classroom') ?? '',
                uid: e.get('uid'),
              ))
          .toList();
    });
  }

  Future<bool> updateStudent(StudentModel studentModel) async {
    try {
      DatabaseService().students.doc(studentModel.uid).update(
            studentModel.toJson(),
          );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteStudent(String uid) async {
    try {
      await DatabaseService().students.doc(uid).delete();
      return true;
    } catch (e) {
      print('err: $e');
    }
    return false;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sporthall_booking_system/Model/StatusModel.dart';
import 'package:sporthall_booking_system/Services/Database.dart';
import 'package:sporthall_booking_system/database.dart';

class StatusServiceProvider extends ChangeNotifier {
  //upload status
  Future<bool> uploadStatus(StatusModel statusModel) async {
    try {
      final docref = DatabaseService().status.doc();
      statusModel.statusID = docref.id;
      await docref.set(statusModel.toJson()).catchError((e) => throw ('error upload $e'));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addComment(StatusModel statusModel, Comment comment) async {
    try {
      await DatabaseService().status.doc(statusModel.statusID).update({
        'comments': FieldValue.arrayUnion([comment.toJson()])
      });
      return true;
    } catch (e) {
      throw ("hi saya error comment $e");
      // return false;
    }
  }

  Future<bool> deleteStatus(String statusID) async {
    try {
      await DatabaseService().status.doc(statusID).delete();
      return true;
    } catch (e) {
      throw ("delete error $e");
    }
  }

  Future<bool> editStatus(String statusID, String newCaption) async {
    try {
      await DatabaseService().status.doc(statusID).update({"caption": newCaption});
      return true;
    } catch (e) {
      throw ("error update caption $e");
    }
  }

  Stream<List<StatusModel>> getListStreamStatus() {
    return DatabaseService().status.snapshots().map((event) {
      return event.docs.map((e) {
        StatusModel stat = StatusModel().fromFirebaseQuery(e);
        return stat;
      }).toList();
    });
  }
}

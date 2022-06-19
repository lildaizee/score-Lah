import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/providers/AuthServiceProvider.dart';

class MediaServiceProvider extends ChangeNotifier {
  Map<String, int> _bytesTransferredMap = Map();
  Map<String, int> _bytesTotalMap = Map();

  int get _progressValue {
    if (_bytesTransferredMap.values.length == 0) {
      return 0;
    }
    int totalTransferred = _bytesTransferredMap.values.reduce((value, element) => (value ?? 0) + (element ?? 0));
    int totalBytes = _bytesTotalMap.values.reduce((value, element) => (value ?? 0) + (element ?? 0));
    if (totalTransferred == null || totalBytes == null || _bytesTotalMap.values.contains(-1)) {
      return 0;
    }
    return (100 * (totalTransferred / totalBytes)).floor();
  }

  static Future<List<String>> selectStatusPhotos({BuildContext context}) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      withData: true,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null && result.files.length > 0) {
      List<Uint8List> list = result.files.map((e) => e.bytes).toList();
      if (list.length > 0) {
        List<String> listphoto = await context.read<MediaServiceProvider>().uploadDialog(context: context, images: list);
        return listphoto;
      }
    }
    return [];
  }

  Future<List<String>> uploadDialog({BuildContext context, List<Uint8List> images}) {
    Future<List<String>> futures = Future.wait(_toListFuture(context: context, images: images));
    return showDialog<List<String>>(
      barrierDismissible: false,
      context: context,
      builder: (newcontext) {
        return FutureBuilder<List<String>>(
          future: futures.then((value) {
            Navigator.of(newcontext).pop(value);
            return value;
          }).onError((error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload Failed')));
            Navigator.of(newcontext).pop(null);
            return futures;
          }),
          builder: (context, snapshot) {
            return Material(
              color: Colors.transparent,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Gap(10),
                    if (_progressValue != null)
                      Text(
                        'Uploading ${_progressValue.toStringAsFixed(0)}%',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    if (_progressValue == null)
                      Text(
                        'Uploading...',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Future<String>> _toListFuture({BuildContext context, List<Uint8List> images}) => images.map((e) => _uploadToStorage(context: context, imageData: e, childPath: 'statusPhoto/${context.read<AuthServiceProvider>().getUserID}')).toList();

  Future<String> _uploadToStorage({BuildContext context, Uint8List imageData, String childPath}) {
    final FirebaseStorage _storage = FirebaseStorage.instance;
    int random = 100000 + Random().nextInt(899999);
    String path = '$childPath-$random-${Timestamp.now().millisecondsSinceEpoch}.jpeg';
    UploadTask _uploadTask = _storage.ref().child(path).putData(
          imageData,
          SettableMetadata(contentType: "image/jpeg"),
        );
    return _listenUpload(context: context, uploadTask: _uploadTask, key: path);
  }

  Future<String> _listenUpload({BuildContext context, UploadTask uploadTask, String key}) {
    uploadTask.snapshotEvents.listen((event) {
      _bytesTransferredMap[key] = event.bytesTransferred;
      _bytesTotalMap[key] = event.totalBytes;
      notifyListeners();
    }).onError((error) {
      throw ('error $error');
    });

    return uploadTask.whenComplete(() async {}).then((value) {
      return uploadTask.then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
    }).onError((error, stackTrace) => throw ("Error uploading $error"));
  }
}

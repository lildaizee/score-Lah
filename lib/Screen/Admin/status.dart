import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sporthall_booking_system/Model/Student.dart';
import 'package:sporthall_booking_system/Screen/Admin/storage_service.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import 'package:sporthall_booking_system/Screen/drawer.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Services/Database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class addStatus extends StatefulWidget {
  @override
  _statusState createState() => _statusState();
}

class _statusState extends State<addStatus> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Status"),
      ),
      body: Column(children: [
        Center(
            child: ElevatedButton(
          onPressed: () async {
            final results = await FilePicker.platform.pickFiles(
              allowMultiple: false,
              type: FileType.custom,
              allowedExtensions: ['png', 'jpg'],
            );

            if (results == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("No file selected."),
                ),
              );

              return null;
            }

            final path = results.files.single.path;
            final filename = results.files.single.name;

            storage.uploadFile(path, filename).then((value) => print("Done"));
          },
          child: Text("Upload File"),
        )),
        FutureBuilder(
            future: storage.listFiles(),
            builder: (BuildContext context,
                AsyncSnapshot<firebase_storage.ListResult> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(snapshot.data.items[index].name),
                          ),
                        );
                      }),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Container();
            }),
        FutureBuilder(
            future: storage.downloadURL("IMG_20220612_032938.jpg"),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  width: 300,
                  height: 250,
                  child: Image.network(snapshot.data, fit: BoxFit.cover),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Container();
            })
      ]),
      drawer: SideDrawer(),
    );
  }
}

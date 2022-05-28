import 'package:flutter/material.dart';
//import 'package:sporthall_booking_system/Services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporthall_booking_system/Model/Users.dart';
import 'package:sporthall_booking_system/Services/Database.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String username, fullname, contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return SafeArea(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: Container(
                          width: 700,
                          height: 250,
                          child: Image.asset('Images/Profile.png')),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 60.0, right: 60.0, top: 70, bottom: 0),
                      child: Center(
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.people,
                                color: Colors.blue,
                              ),
                              //floatingLabelBehavior: (color : Colors.blue),
                              labelText: "$fullname",
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 22)),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 60.0, right: 60.0, top: 40, bottom: 10),
                      child: Center(
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.call_to_action_rounded,
                                color: Colors.blue,
                              ),
                              labelText: "$username",
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 22)),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 60.0, right: 60.0, top: 30, bottom: 0),
                      child: Center(
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.call,
                                color: Colors.blue,
                              ),
                              labelText: "$contact",
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 22)),
                        ),
                      )),
                ],
              ));
            }));
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        fullname = ds.data()['fullname'];
        username = ds.data()['username'];
        contact = ds.data()['contact'];
        print(fullname);
        print(username);
        print(contact);
      }).catchError((e) {
        print(e);
      });
  }
}

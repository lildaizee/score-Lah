import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String username, fullname, contact;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Center(
                child: CircularProgressIndicator(),
              );
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/Profile.png',
                    width: 700,
                    height: 250,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 60.0, right: 60.0, top: 20, bottom: 0),
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
                          left: 60.0, right: 60.0, top: 20, bottom: 10),
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
                        left: 60.0, right: 60.0, top: 20, bottom: 0),
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
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
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

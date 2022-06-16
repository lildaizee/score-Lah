import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporthall_booking_system/Screen/Homepage/home.dart';
import 'package:sporthall_booking_system/Screen/Booking/booking.dart';

class SporthallHall extends StatefulWidget {
  @override
  _SporthallHallState createState() => _SporthallHallState();
}

class _SporthallHallState extends State<SporthallHall> {
  var selectedHall, selectedBookingdate, selectedSlot;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  // get sporthall => null;

  // get sporthallDatevalue => null;

  // get sporthallTimevalue => null;

  getSelectedHall(selectedHall) {
    this.selectedHall = selectedHall;
  }

  getSelectedBookingdate(selectedBookingdate) {
    this.selectedBookingdate = selectedBookingdate;
  }

  getSelectedSlot(selectedSlot) {
    this.selectedSlot = selectedSlot;
  }

  createdata() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentReference bk = FirebaseFirestore.instance
        .collection('BookingSporthall')
        .doc(firebaseUser.uid);
    Map<String, dynamic> booking = {
      "selectedHall": selectedHall,
      "selectedBookingdate": selectedBookingdate,
      "selectedSlot": selectedSlot,
    };
    bk.set(booking).whenComplete(() {
      //print("Creating Room Booking Successfully");
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Message"),
          content: Text("Hall Booked Successfully!"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Booking()),
                );
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKeyValue,
      child: new ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        children: <Widget>[
          new Container(
            child: Column(
              //countDocuments(),
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 30.0, left: 0, right: 0),
                  child: Center(
                    child: Container(
                        width: 350,
                        height: 200,
                        child: Image.asset('assets/images/Sporthall_1.png')),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.blueGrey,
              //height: 40,
              elevation: 10,
              child: Column(
                //countDocuments(),
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: new Center(
                        child: new Text(
                            'Available Facilities: \n\n- Toilet  \n- Sporthall 2 \n- Gym 1 \n- Gym 2',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white))),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 40.0),
          //Dynamic-Room
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Sporthall")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  const Text("Loading.....");
                } else {
                  List<DropdownMenuItem> sporthall = [];
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    DocumentSnapshot snap = snapshot.data.docs[i];
                    sporthall.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.id,
                          style: TextStyle(color: Colors.blue),
                        ),
                        value: "${snap.id}",
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                          padding: EdgeInsets.only(
                              top: 30.0, bottom: 0.0, left: 30.0, right: 20.0),
                          child: Text('Choose Hall :',
                              style: new TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(width: 10.0),
                      new Container(
                          padding: EdgeInsets.only(
                              top: 30.0, bottom: 0.0, left: 30.0, right: 20.0),
                          child: DropdownButton(
                            items: sporthall,
                            onChanged: (sporthallvalue) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected hall is $sporthallvalue',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setState(() {
                                selectedHall = sporthallvalue;
                              });
                            },
                            value: selectedHall,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Hall",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )),
                    ],
                  );
                }
                return Text("Done");
              }),
          //Dynamic Date
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("SporthallDate")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  const Text("Loading.....");
                } else {
                  List<DropdownMenuItem> sporthallDate = [];
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    DocumentSnapshot snap = snapshot.data.docs[i];
                    sporthallDate.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.id,
                          style: TextStyle(color: Colors.blue),
                        ),
                        value: "${snap.id}",
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 0.0, left: 30.0, right: 10.0),
                          child: Text('Choose Date :',
                              style: new TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold)
                              //   fontFamily: 'Roboto',
                              //   color: new Color(0xFF26C6DA),
                              )),
                      SizedBox(width: 50.0),
                      new Container(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 0.0, left: 10.0, right: 10.0),
                          child: DropdownButton(
                            items: sporthallDate,
                            onChanged: (sporthallDatevalue) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected date is $sporthallDatevalue',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setState(() {
                                selectedBookingdate = sporthallDatevalue;
                              });
                            },
                            value: selectedBookingdate,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Date",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )),
                    ],
                  );
                }
                return Text("Done");
              }),

          //Dynamic Time
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("SporthallTime")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  const Text("Loading.....");
                } else {
                  List<DropdownMenuItem> SporthallTime = [];
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    DocumentSnapshot snap = snapshot.data.docs[i];
                    SporthallTime.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.id,
                          style: TextStyle(color: Colors.blue),
                        ),
                        value: "${snap.id}",
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 0.0, left: 30.0, right: 10.0),
                          child: Text('Choose Time :',
                              style: new TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold)
                              //   fontFamily: 'Roboto',
                              //   color: new Color(0xFF26C6DA),
                              )),
                      new Container(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 0.0, left: 10.0, right: 10.0),
                          child: DropdownButton(
                            items: SporthallTime,
                            onChanged: (sporthallTimevalue) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected date is $sporthallTimevalue',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setState(() {
                                selectedSlot = sporthallTimevalue;
                              });
                            },
                            value: selectedSlot,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Slot",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )),
                    ],
                  );
                }
                return Text("Done");
              }),
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Container(
                height: 40,
                width: 140,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(width: 30),
              new Container(
                height: 40,
                width: 140,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    createdata();
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

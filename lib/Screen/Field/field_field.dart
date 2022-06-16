import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporthall_booking_system/Screen/Homepage/home.dart';
import 'package:sporthall_booking_system/Screen/Booking/booking.dart';

class FieldField extends StatefulWidget {
  @override
  _FieldFieldState createState() => _FieldFieldState();
}

class _FieldFieldState extends State<FieldField> {
  var selectedField, selectedBookingdate, selectedSlot;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  getSelectedRoom(selectedField) {
    this.selectedField = selectedField;
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
        .collection('BookingField')
        .doc(firebaseUser.uid);
    Map<String, dynamic> booking = {
      "selectedField": selectedField,
      "selectedBookingdate": selectedBookingdate,
      "selectedSlot": selectedSlot,
    };
    bk.set(booking).whenComplete(() {
      // print("Creating Field Booking Successfully");
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Message"),
          content: Text("Field Booked Successfully!"),
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
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Container(
                        width: 400,
                        height: 200,
                        child: Image.asset('assets/images/Field_2.png')),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: new Container(
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
                              'Available Facilities: \n\n- Ball  \n- Chair \n- Toilet \n- Net',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white))),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Dynamic-Room
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("Field").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  const Text("Loading.....");
                } else {
                  List<DropdownMenuItem> field = [];
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    DocumentSnapshot snap = snapshot.data.docs[i];
                    field.add(
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
                          child: Text('Choose Field :',
                              style: new TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(width: 10.0),
                      new Container(
                          padding: EdgeInsets.only(
                              top: 30.0, bottom: 0.0, left: 30.0, right: 20.0),
                          child: DropdownButton(
                            items: field,
                            onChanged: (fieldvalue) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected field is $fieldvalue',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedField = fieldvalue;
                              });
                            },
                            value: selectedField,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Field",
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
                  .collection("FieldDate")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  const Text("Loading.....");
                } else {
                  List<DropdownMenuItem> fieldDate = [];
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    DocumentSnapshot snap = snapshot.data.docs[i];
                    fieldDate.add(
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
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(width: 50.0),
                      new Container(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 0.0, left: 10.0, right: 10.0),
                          child: DropdownButton(
                            items: fieldDate,
                            onChanged: (fieldDatevalue) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected date is $fieldDatevalue',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedBookingdate = fieldDatevalue;
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
                  .collection("FieldTime")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  const Text("Loading.....");
                } else {
                  List<DropdownMenuItem> FieldTime = [];
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    DocumentSnapshot snap = snapshot.data.docs[i];
                    FieldTime.add(
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
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold))),
                      new Container(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 0.0, left: 10.0, right: 10.0),
                          child: DropdownButton(
                            items: FieldTime,
                            onChanged: (fieldTimevalue) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected date is $fieldTimevalue',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedSlot = fieldTimevalue;
                              });
                            },
                            value: selectedSlot,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Time Slot",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
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

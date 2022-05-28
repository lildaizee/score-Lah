import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporthall_booking_system/Screen/Booking/booking.dart';
import 'package:sporthall_booking_system/Screen/Booking/booking_record.dart';
import 'package:sporthall_booking_system/Screen/Homepage/home.dart';

class UpdateSporthallBooking extends StatefulWidget {
  @override
  _UpdateSporthallBookingState createState() => _UpdateSporthallBookingState();
}

class _UpdateSporthallBookingState extends State<UpdateSporthallBooking> {
  String dateSporthall, hallSporthall, timeSporthall;
  var selectedHall, selectedBookingdate, selectedSlot;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

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
      // print("Creating Room Booking Successfully");
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Message"),
          content: Text("Hall Booking Updated Successfully!"),
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
        body: FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Form(
                autovalidateMode: AutovalidateMode.always, key: _formKeyValue,
                child: new ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[
                    new Container(
                      child: Column(
                        //countDocuments(),
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: Container(
                                  width: 300,
                                  height: 250,
                                  child: Image.asset('Images/Sporthall_2.png')),
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
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[],
                        ),
                      ),
                    ),
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
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
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
                                        top: 30.0,
                                        bottom: 0.0,
                                        left: 30.0,
                                        right: 20.0),
                                    child: Text('Choose Hall :',
                                        style: new TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold))),
                                SizedBox(width: 10.0),
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: 30.0,
                                        bottom: 0.0,
                                        left: 30.0,
                                        right: 20.0),
                                    child: DropdownButton(
                                      items: sporthall,
                                      onChanged: (sporthallhallvalue) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Selected hall is $sporthallhallvalue',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          selectedHall = sporthallhallvalue;
                                        });
                                      },
                                      value: selectedHall,
                                      isExpanded: false,
                                      hint: new Text(
                                        '$hallSporthall',
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
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
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
                                        top: 10.0,
                                        bottom: 0.0,
                                        left: 30.0,
                                        right: 10.0),
                                    child: Text('Choose Date :',
                                        style: new TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold))),
                                SizedBox(width: 50.0),
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 0.0,
                                        left: 10.0,
                                        right: 10.0),
                                    child: DropdownButton(
                                      items: sporthallDate,
                                      onChanged: (sporthallDatevalue) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Selected date is $sporthallDatevalue',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          selectedBookingdate =
                                              sporthallDatevalue;
                                        });
                                      },
                                      value: selectedBookingdate,
                                      isExpanded: false,
                                      hint: new Text(
                                        '$dateSporthall',
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
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
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
                                        top: 10.0,
                                        bottom: 0.0,
                                        left: 30.0,
                                        right: 10.0),
                                    child: Text('Choose Time :',
                                        style: new TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold)
                                        //   fontFamily: 'Roboto',
                                        //   color: new Color(0xFF26C6DA),
                                        )),
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 0.0,
                                        left: 10.0,
                                        right: 10.0),
                                    child: DropdownButton(
                                      items: SporthallTime,
                                      onChanged: (sporthallTimevalue) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Selected date is $sporthallTimevalue',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          selectedSlot = sporthallTimevalue;
                                        });
                                      },
                                      value: selectedSlot,
                                      isExpanded: false,
                                      hint: new Text(
                                        '$timeSporthall',
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
                                MaterialPageRoute(
                                    builder: (context) => Booking()),
                              );
                            },
                            child: Text(
                              'Cancel',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                              'Update',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }));
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('BookingSporthall')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        dateSporthall = ds.data()['selectedBookingdate'];
        hallSporthall = ds.data()['selectedHall'];
        timeSporthall = ds.data()['selectedSlot'];
        print(dateSporthall);
        print(hallSporthall);
        print(timeSporthall);
      }).catchError((e) {
        print(e);
      });
    } else {
      return print('No Booking Has Been Made');
    }
  }
}

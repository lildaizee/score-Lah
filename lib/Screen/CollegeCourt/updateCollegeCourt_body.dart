import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporthall_booking_system/Screen/Booking/Booking.dart';

class UpdateCollegeCourtBooking extends StatefulWidget {
  @override
  _UpdateCollegeCourtBookingState createState() =>
      _UpdateCollegeCourtBookingState();
}

class _UpdateCollegeCourtBookingState extends State<UpdateCollegeCourtBooking> {
  String dateCollegeCourt, courtCollegeCourt, timeCollegeCourt;
  var selectedCourt, selectedBookingdate, selectedSlot;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  getSelectedCourt(selectedCourt) {
    this.selectedCourt = selectedCourt;
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
        .collection('BookingCollegeCourt')
        .doc(firebaseUser.uid);
    Map<String, dynamic> booking = {
      "selectedCourt": selectedCourt,
      "selectedBookingdate": selectedBookingdate,
      "selectedSlot": selectedSlot,
    };
    bk.set(booking).whenComplete(() {
      // print("Creating Court Booking Successfully");
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("DONE!"),
          content: Text("Court Booking Updated Successfully!"),
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
                key: _formKeyValue,
                //autovalidate: true,
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
                                  child: Image.asset('Images/KTDI.png')),
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
                            .collection("CollegeCourt")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            const Text("Loading.....");
                          } else {
                            List<DropdownMenuItem> collegeCourt = [];
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              collegeCourt.add(
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
                                    child: Text('Choose Court:',
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
                                      items: collegeCourt,
                                      onChanged: (collegeCourtcourtvalue) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Selected court is $collegeCourtcourtvalue',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          selectedCourt =
                                              collegeCourtcourtvalue;
                                        });
                                      },
                                      value: selectedCourt,
                                      isExpanded: false,
                                      hint: new Text(
                                        '$courtCollegeCourt ',
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
                            .collection("CollegeCourtDate")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            const Text("Loading.....");
                          } else {
                            List<DropdownMenuItem> collegeCourtDate = [];
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              collegeCourtDate.add(
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
                                      items: collegeCourtDate,
                                      onChanged: (collegeCourtDatevalue) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Selected date is $collegeCourtDatevalue',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          selectedBookingdate =
                                              collegeCourtDatevalue;
                                        });
                                      },
                                      value: selectedBookingdate,
                                      isExpanded: false,
                                      hint: new Text(
                                        '$dateCollegeCourt',
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
                            .collection("CollegeCourtTime")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            const Text("Loading.....");
                          } else {
                            List<DropdownMenuItem> CollegeCourtTime = [];
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              CollegeCourtTime.add(
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
                                      items: CollegeCourtTime,
                                      onChanged: (collegeCourtTimevalue) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Selected date is $collegeCourtTimevalue',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          selectedSlot = collegeCourtTimevalue;
                                        });
                                      },
                                      value: selectedSlot,
                                      isExpanded: false,
                                      hint: new Text(
                                        '$timeCollegeCourt',
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
          .collection('BookingCollegeCourt')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        dateCollegeCourt = ds.data()['selectedBookingdate'];
        courtCollegeCourt = ds.data()['selectedCourt'];
        timeCollegeCourt = ds.data()['selectedSlot'];
        print(dateCollegeCourt);
        print(courtCollegeCourt);
        print(timeCollegeCourt);
      }).catchError((e) {
        print(e);
      });
    } else {
      return print('No Booking Has Been Made');
    }
  }
}

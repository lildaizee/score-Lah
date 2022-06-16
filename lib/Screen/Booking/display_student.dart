import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporthall_booking_system/Screen/Booking/booking.dart';
import 'package:sporthall_booking_system/Screen/CollegeCourt/updateCollegeCourt.dart';
import 'package:sporthall_booking_system/Screen/InDevelopment/Maintenance.dart';
import 'package:sporthall_booking_system/Screen/Sporthall/sporthall.dart';
import 'package:sporthall_booking_system/Screen/CollegeCourt/collegeCourt.dart';
import 'package:sporthall_booking_system/Screen/Field/field.dart';
import 'package:sporthall_booking_system/Screen/Sporthall/updateSporthall.dart';
import 'package:sporthall_booking_system/Screen/Field/updateField.dart';
import 'package:sporthall_booking_system/Screen/drawer.dart';
import 'package:sporthall_booking_system/Screen/widgets/app_bar.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';

class DisplayStudent extends StatefulWidget {
  @override
  _DisplayStudentState createState() => _DisplayStudentState();
}

class _DisplayStudentState extends State<DisplayStudent> {
  String dateSporthall, hallSporthall, timeSporthall;
  String dateCollegeCourt, courtCollegeCourt, timeCollegeCourt;
  String dateField, fieldField, timeField;

  @override
  Widget build(BuildContext context) {
    //return SafeArea(
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Student Record',
      ),
      //children: Column(children: <Widget>[
      body: Column(children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            //     child: Center(
            //       child: Container(
            //           width: 500, height: 150, child: Image.asset('Images/Logo.png')),
          ),
        ),
        // ),
        FutureBuilder(
            future: _fetchSporthall(),
            builder: (context, snapshot) {
              if (hallSporthall != null) {
                if (snapshot.connectionState != ConnectionState.done)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return new Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.blue.shade100,
                    //height: 40,
                    elevation: 10,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      //countDocuments(),
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.article_outlined, size: 60),
                          title: Text('1. Thalia Binti Mohd Naim',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          subtitle: Text(
                              '\nClass : $hallSporthall \nAge : $dateSporthall \nParent : $timeSporthall',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 30.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              new Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(20)),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Delete Thalia Binti Mohd Naim',
                                              textAlign: TextAlign.center,
                                            ),
                                            content: Text(
                                                'Are you sure you want to delete the student?'),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                              FlatButton(
                                                  onPressed: () {
                                                    deleteSporthallRecord()
                                                        .whenComplete(() =>
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Booking()),
                                                            ));
                                                  },
                                                  child: Text('Delete'))
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                              new Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20)),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateSporthall()),
                                    );
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueGrey[200],
                  //height: 40,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.article_outlined, size: 60),
                        title: Text('1. Thalia Binti Mohd Naim',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        subtitle: Text('\nNo data for Thalia Naim',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 30.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            new Container(
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UnderMaintenance()),
                                  );
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
        FutureBuilder(
            future: _fetchCollegeCourt(),
            builder: (context, snapshot) {
              if (courtCollegeCourt != null) {
                // if (snapshot.connectionState != ConnectionState.done)
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                return new Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.blue.shade100,
                    //height: 40,
                    elevation: 10,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      //countDocuments(),
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.article_outlined, size: 60),
                          title: Text('2. Mohd Anas bin Adnan',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          subtitle: Text(
                              '\nClass : $courtCollegeCourt \nAge : $dateCollegeCourt \nParent : $timeCollegeCourt',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 30.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              new Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(20)),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Delete Mohd Anas',
                                              textAlign: TextAlign.center,
                                            ),
                                            content: Text(
                                                'Are you sure you want to delete the student?'),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                              FlatButton(
                                                  onPressed: () {
                                                    deleteCollegeCourtRecord()
                                                        .whenComplete(() =>
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Booking()),
                                                            ));
                                                  },
                                                  child: Text('Delete'))
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                              new Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20)),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateCollegeCourt()),
                                    );
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueGrey[200],
                  //height: 40,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.article_outlined, size: 60),
                        title: Text('2. Mohd Anas Bin Adnan',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        subtitle: Text('\nNo data for Mohd Anas',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 30.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            new Container(
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UnderMaintenance()),
                                  );
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
        FutureBuilder(
            future: _fetchField(),
            builder: (context, snapshot) {
              if (fieldField != null) {
                return new Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.blue.shade100,
                    //height: 40,
                    elevation: 10,

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.article_outlined, size: 60),
                          title: Text('3. Ali',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          subtitle: Text(
                              '\nClass : $fieldField \nAge : $dateField \nParent : $timeField',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 30.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              new Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(20)),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Delete Ali',
                                              textAlign: TextAlign.center,
                                            ),
                                            content: Text(
                                                'Are you sure you want to delete the student?'),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                              FlatButton(
                                                  onPressed: () {
                                                    deleteFieldRecord()
                                                        .whenComplete(() =>
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Booking()),
                                                            ));
                                                  },
                                                  child: Text('Delete'))
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                              new Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20)),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateField()),
                                    );
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueGrey[200],
                  //height: 40,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.article_outlined, size: 60),
                        title: Text('3. Ali',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        subtitle: Text('\nNo data for Ali',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 30.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            new Container(
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UnderMaintenance()),
                                  );
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ]),
      drawer: SideDrawer(),
    );
  }

  _fetchSporthall() async {
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
      return print('No data was inserted');
    }
  }

  _fetchCollegeCourt() async {
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
      return print('No data was inserted');
    }
  }

  _fetchField() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('BookingField')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        dateField = ds.data()['selectedBookingdate'];
        fieldField = ds.data()['selectedField'];
        timeField = ds.data()['selectedSlot'];
        print(dateField);
        print(fieldField);
        print(timeField);
      }).catchError((e) {
        print(e);
      });
    } else {
      return print('No data was inserted');
    }
  }

  deleteSporthallRecord() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('BookingSporthall')
          .doc(firebaseUser.uid)
          .delete();
    } else {
      return print('failed to delete');
    }
  }

  deleteCollegeCourtRecord() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('BookingCollegeCourt')
          .doc(firebaseUser.uid)
          .delete();
    } else {
      return print('failed to delete');
    }
  }
}

deleteFieldRecord() async {
  final firebaseUser = await FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    await FirebaseFirestore.instance
        .collection('BookingField')
        .doc(firebaseUser.uid)
        .delete();
  } else {
    return print('failed to delete');
  }
}

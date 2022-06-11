import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/Sporthall/sporthall.dart';
import 'package:sporthall_booking_system/Screen/CollegeCourt/collegeCourt.dart';
import 'package:sporthall_booking_system/Screen/Field/field.dart';
import 'package:sporthall_booking_system/Screen/InDevelopment/Maintenance.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

countDocuments() async {
  QuerySnapshot _myDoc =
      await FirebaseFirestore.instance.collection('Sporthall').get();
  List<DocumentSnapshot> _myDocCount = _myDoc.docs;
  int length = (_myDocCount.length);
  print(length);
  return length;
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: <Widget>[
      Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
          child: Center(
            child: Container(
                width: 500, height: 150, child: Image.asset('Images/Logo.png')),
          ),
        ),
      ),
      new Container(
        width: 350,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue.shade100,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.class__outlined, size: 60),
                title: Text('En Shakespear',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                subtitle: Text('Class for 4 years old',
                    style: TextStyle(color: Colors.black54, fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 83, 113, 197),
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    child: const Text('Go to class',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        // MaterialPageRoute(builder: (context) => Sporthall()),
                        MaterialPageRoute(
                            builder: (context) => UnderMaintenance()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        //Use of SizedBox
        height: 25,
      ),
      new Container(
        width: 350,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue.shade100,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.class__outlined, size: 60),
                title: Text('En Einstein',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                subtitle: Text('Class for 5 years old',
                    style: TextStyle(color: Colors.black54, fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 83, 113, 197),
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    child: const Text('Go to class',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        //MaterialPageRoute(builder: (context) => CollegeCourt()),
                        MaterialPageRoute(
                            builder: (context) => UnderMaintenance()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        //Use of SizedBox
        height: 25,
      ),
      new Container(
        width: 350,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue.shade100,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.class__outlined, size: 60),
                title: Text('En Owens',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                subtitle: Text('Class for 6 years old',
                    style: TextStyle(color: Colors.black54, fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 83, 113, 197),
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    child: const Text('Go to class',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        //MaterialPageRoute(builder: (context) => Field()),
                        MaterialPageRoute(
                            builder: (context) => UnderMaintenance()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Model/StudentModel.dart';
import 'package:sporthall_booking_system/providers/StudentServiceProvider.dart';

class CrudStudentBody extends StatefulWidget {
  final String age;
  final String name;
  final String classRoom;
  final String uid;
  const CrudStudentBody({
    Key key,
    this.age,
    this.name,
    this.classRoom,
    this.uid,
  }) : super(key: key);

  @override
  State<CrudStudentBody> createState() => _CrudStudentBodyState();
}

class _CrudStudentBodyState extends State<CrudStudentBody> {
  int dropdownAge;
  TextEditingController controllerName;
  TextEditingController controllerClassRoom;
  bool isUpdate = false;

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.age != '' && widget.age != null) {
      dropdownAge = int.parse(widget.age);
      isUpdate = true;
    }
    if (widget.name != '' && widget.name != null) {
      controllerName = TextEditingController(text: widget.name);
    } else {
      controllerName = TextEditingController();
    }
    if (widget.classRoom != '' && widget.classRoom != null) {
      controllerClassRoom = TextEditingController(text: widget.classRoom);
    } else {
      controllerClassRoom = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          Gap(MediaQuery.of(context).size.height * 0.1),
          TextFormField(
            controller: controllerName,
            decoration: InputDecoration(
              hintText: 'Fullname',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == '' || value.isEmpty) {
                return 'Please enter student name';
              }
              return null;
            },
          ),
          Gap(24),
          DropdownButtonFormField(
            items: [4, 5, 6]
                .map(
                  (e) => DropdownMenuItem(
                    child: Text('$e'),
                    value: e,
                  ),
                )
                .toList(),
            validator: (val) => val == null ? 'Please enter student age' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            value: dropdownAge,
            hint: Text('Select age'),
            onChanged: (val) {
              setState(() {
                dropdownAge = val;
                if (val == 4) {
                  controllerClassRoom.text = 'En Shakespeer';
                } else if (val == 5) {
                  controllerClassRoom.text = 'En Einstein';
                } else {
                  controllerClassRoom.text = 'En Owens';
                }
              });
            },
          ),
          Gap(24),
          TextFormField(
            readOnly: true,
            controller: controllerClassRoom,
            decoration: InputDecoration(
              hintText: 'Student class',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == '' || value.isEmpty) {
                return 'Please enter student name';
              }
              return null;
            },
          ),
          Gap(MediaQuery.of(context).size.height * 0.15),
          ElevatedButton(
            onPressed: () {
              if (_key.currentState.validate()) {
                final student = StudentModel(
                  fullname: controllerName.text,
                  age: '$dropdownAge',
                  classroom: controllerClassRoom.text,
                  uid: widget.uid ?? '',
                );
                if (isUpdate) {
                  context.read<StudentServiceProvider>().updateStudent(student).then((value) {
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Student updated')));
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fail to update student')));
                    }
                  });
                } else {
                  context.read<StudentServiceProvider>().createNewStudent(student).then((value) {
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Student Added')));
                      setState(() {
                        dropdownAge = null;
                        controllerName.clear();
                        controllerClassRoom.clear();
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fail to add student')));
                    }
                  });
                }
              }
            },
            child: Text(isUpdate ? 'Update' : 'Create'),
          ),
        ],
      ),
    );
  }
}

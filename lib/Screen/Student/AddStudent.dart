import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/Student/component/crudStudentBody.dart';
import 'package:sporthall_booking_system/Screen/drawer.dart';
import 'package:sporthall_booking_system/Screen/widgets/app_bar.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Student'),
      body: CrudStudentBody(
        age: '',
        name: '',
        classRoom: '',
        uid: '',
      ),
      drawer: SideDrawer(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Model/StudentModel.dart';
import 'package:sporthall_booking_system/Screen/Student/component/crudStudentBody.dart';
import 'package:sporthall_booking_system/Screen/drawer.dart';
import 'package:sporthall_booking_system/Screen/widgets/app_bar.dart';
import 'package:sporthall_booking_system/providers/AuthServiceProvider.dart';
import 'package:sporthall_booking_system/providers/StudentServiceProvider.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Student Record',
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                  stream: context.watch<StudentServiceProvider>().getListStudent(),
                  builder: (context, AsyncSnapshot<List<StudentModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return Text('No student records');
                    }
                    if (snapshot.hasError) {
                      return Text('Error occured');
                    }
                    List<StudentModel> student = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: student.length,
                      itemBuilder: (context, index) {
                        StudentModel s = student[index];
                        return Container(
                          margin: EdgeInsets.only(
                            top: index == 0 ? 20 : 10,
                            bottom: index == student.length - 1 ? 20 : 0,
                            left: 20,
                            right: 20,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.blue.shade100,
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.article_outlined,
                                        size: 60,
                                      ),
                                      Gap(20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Name: ${s.fullname}'),
                                            Gap(5),
                                            Text('Age : ' + s.age),
                                            Gap(5),
                                            Text('Classroom : ' + s.classroom),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(10),
                                  context.watch<AuthServiceProvider>().getUserData.userType == 'Parent'
                                      ? SizedBox()
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (newcontext) {
                                                      return AlertDialog(
                                                        title: Text('Delete warning'),
                                                        content: Text('Delete this student?'),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(newcontext).pop();
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              primary: Colors.grey,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                            ),
                                                            child: Text('Cancel'),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () async {
                                                              await context.read<StudentServiceProvider>().deleteStudent(s.uid).then((value) {
                                                                if (value) {
                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully deleted')));
                                                                } else {
                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully deleted')));
                                                                }
                                                                Navigator.of(newcontext).pop();
                                                              });
                                                            },
                                                            style: ElevatedButton.styleFrom(primary: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                            child: Text('Delete'),
                                                          ),
                                                        ],
                                                        actionsAlignment: MainAxisAlignment.center,
                                                      );
                                                    });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: Text('Delete'),
                                            ),
                                            Gap(15),
                                            ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (newcontext) {
                                                      return Scaffold(
                                                        appBar: AppBar(
                                                          title: Text(
                                                            'Update Student',
                                                          ),
                                                        ),
                                                        body: CrudStudentBody(
                                                          age: s.age,
                                                          name: s.fullname,
                                                          classRoom: s.classroom,
                                                          uid: s.uid,
                                                        ),
                                                      );
                                                    });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: Text('Update'),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        drawer: SideDrawer(),
      ),
    );
  }
}

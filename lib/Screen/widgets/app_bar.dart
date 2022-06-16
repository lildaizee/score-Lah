import 'package:flutter/material.dart';
import 'package:sporthall_booking_system/Screen/AuthScreen/login.dart';
import 'package:sporthall_booking_system/Services/auth_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key key, this.title}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(56);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            //sign Out User
            showDialog(
                context: context,
                builder: (ctxt) {
                  return AlertDialog(
                    title: Text('Confirmation'),
                    content: Text('Are you sure to log out?'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctxt);
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AuthClass().signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                              (route) => false);
                        },
                        child: Text('Proceed'),
                      ),
                    ],
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                  );
                });
          },
        )
      ],
    );
  }
}

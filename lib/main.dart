import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Screen/splash.dart';
import 'package:sporthall_booking_system/providers/AuthServiceProvider.dart';
import 'package:sporthall_booking_system/providers/MediaServiceProvider.dart';
import 'package:sporthall_booking_system/providers/StatusServiceProvider.dart';
import 'package:sporthall_booking_system/providers/StudentServiceProvider.dart';
import 'package:sporthall_booking_system/providers/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthServiceProvider>.value(value: authServiceProvider),
        ChangeNotifierProvider<StudentServiceProvider>.value(value: studentServiceProvider),
        ChangeNotifierProvider<MediaServiceProvider>.value(value: mediaServiceProvider),
        ChangeNotifierProvider<StatusServiceProvider>.value(value: statusServiceProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(backgroundColor: Colors.purple[50]),
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization.then(
        (value) => context.read<AuthServiceProvider>().initialize(),
      ),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Splash();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

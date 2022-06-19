import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sporthall_booking_system/Model/Users.dart';
import 'package:sporthall_booking_system/Services/Database.dart';

class AuthClass extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserData user;

  initialize() {}

  UserData get getUser => user;

  Stream<User> get authStateChange {
    return _auth.authStateChanges();
  }

  //Get UserID
  String getCurrentUserID() {
    return _auth.currentUser.uid;
  }

  //Get Current User
  Future getCurrentUser() async {
    return _auth.currentUser;
  }

  //Create Account
  Future createAccount(String email, String password, String fullname, String username, String contact, String usertype) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(fullname, username, contact, usertype, email, user.uid);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign in user
  Future<String> signIN({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) => loadLoggedinUser());
      if (email != null && email == 'admin@gmail.com') {
        return "Admin";
      } else {
        return "Welcome";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  //sign in admin
  loadLoggedinUser() async {
    if (getCurrentUser() != null) {
      await DatabaseService().userProfile.doc(getCurrentUserID()).get().then((value) {
        user = UserData().userFromFirebase(value);
      });
      print('hi saya data ' + user.contact);
      notifyListeners();
    }
  }

  //Reset Password
  Future<String> resetPassword({String email}) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      return "Email sent";
    } catch (e) {
      return "Error occurred";
    }
  }

  //SignOut
  void signOut() {
    _auth.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporthall_booking_system/Model/Users.dart';
//import 'package:sporthall_booking_system/Services/DatabaseManager.dart';
import 'package:sporthall_booking_system/Services/Database.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream<String> get onAuthStateChanged =>
  //   _auth.onAuthStateChanged.map(
  //         (User user) => user?.uid,
  //   );

  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(userid: user.uid) : null;
  }

  Stream<Users> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Get UserID
  Future<String> getCurrentUserID() async {
    String userid = _auth.currentUser.uid;
    return userid;
  }

  //Get Current User
  Future getCurrentUser() async {
    return await _auth.currentUser;
  }

  // //Create user obj based on FirebaseUser
  // User _userFromFireBaseUser(User user) {
  //   return user != null ? User(uid: user.uid) : null;
  // }

  // //auth change user stream
  // Stream<User> get user {
  //   return _auth.authStateChanges()
  //   .map(_userFromFireBaseUser);
  // }

  //Create Account
  Future createAccount(String email, String password, String fullname,
      String username, String contact) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // await DatabaseManager()
      //     .createUserData(fullname, username, contact, user.uid);
      await DatabaseService(uid: user.uid)
          .updateUserData(fullname, username, contact);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Create Booking

//sign in user
  Future<String> signIN({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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

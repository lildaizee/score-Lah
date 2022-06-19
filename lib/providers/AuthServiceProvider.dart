import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sporthall_booking_system/Model/UserModel.dart';
import 'package:sporthall_booking_system/Services/Database.dart';

class AuthServiceProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel _userData;

  UserModel get getUserData => _userData;

  Stream<User> get getAuthStateChange => _auth.authStateChanges();

  String get getUserID => _auth.currentUser.uid;

  User get getCurrentUserAuth => _auth.currentUser;

  initialize() {
    loadSignInUser();
  }

  //signup user
  Future userSignUp(UserModel user, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: user.email, password: password);
      await DatabaseService().updateUserData(user.fullname, user.username, user.contact, user.userType, user.email, result.user.uid);
      return result.user;
    } catch (e) {
      return e;
    }
  }

  Future userSignIn({String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (result != null) {
        await loadSignInUser();
      }
      return _userData.userType;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  void signOut() {
    _auth.signOut().then((value) {
      this._userData = UserModel();
      this.notifyListeners();
    });
  }

  loadSignInUser() async {
    if (_auth.currentUser != null) {
      await DatabaseService().userProfile.doc(getUserID).get().then((value) {
        _userData = UserModel().fromFirebase(value);
      });
      this.notifyListeners();
    }
  }
}

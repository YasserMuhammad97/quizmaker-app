import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/models/user.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Userr _userFromFirebaseUser(User user) {
    return user != null ? Userr(uid: user.uid) : null;
  }

  Future signInWithEmailAndPass(
      String email, String password, BuildContext context) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));

      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

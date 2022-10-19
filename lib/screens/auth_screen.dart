import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(
      String email, String password, String username, bool isLogin) async {
    UserCredential authResult;
    try {
      UserCredential authResult = await authenticate(isLogin, email, password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({'username': username, 'email': email});
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credentials!';

      if (err.message != null) {
        message = err.message.toString();
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (err) {
      print(err);
    }
  }

  Future<UserCredential> authenticate(
      bool isLogin, String email, String password) async {
    if (isLogin) {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } else {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}

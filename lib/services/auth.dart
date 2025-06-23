import 'package:flutter/material.dart';
import 'package:todo_app/model/auth.dart';
import 'package:todo_app/views/login.dart';
import 'package:todo_app/views/task.dart';

class AuthService {
  static Future<void> login(Auth account, BuildContext context) async {
    try {
      // UserCredential userCredential =
      //     await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: account.email,
      //   password: account.password,
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (e) {}
  }

  static Future<void> signup(Auth account) async {
    try {
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(
      //         email: account.email, password: account.password);
    } catch (e) {}
  }

  static Future<void> logout(BuildContext context) async {
    try {
      // await FirebaseAuth.instance.signOut();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginWidget(),
        ),
      );
    } catch (e) {}
  }
}

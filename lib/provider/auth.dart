// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:todo_app/model/auth.dart';
import 'package:todo_app/services/auth.dart';


class AuthController {
  static void signup(String email, String password) async {
    Auth account = Auth(email: email, password: password);
    await AuthService.signup(account);
  }
  static void login(String email, String password, BuildContext context) async {
    Auth account = Auth(email: email, password: password);
    await AuthService.login(account, context);
  }
  static void logout( BuildContext context) async {
   
    await AuthService.logout(context);
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo_app/model/auth.dart';
import 'package:todo_app/provider/auth.dart';
import 'package:todo_app/views/login.dart';
import 'package:todo_app/views/task.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "Welcome!!",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.purple[100],
                          ),
                          label: Text('Email'),
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.purple[100],
                            ),
                            onPressed: () {},
                          ),
                          label: Text('Password'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AuthController.signup(email, password);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginWidget(),
                            ),
                          );
                        },
                        child: Text("Signup"),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

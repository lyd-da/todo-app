import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo_app/provider/auth.dart';
import 'package:todo_app/views/signup.dart';
import 'package:todo_app/views/task.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String email = '';
  String password = '';
  bool hide = true;
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
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.purple[100],
                          ),
                          label: Text('Email'),
                        ),
                      ),
                      TextFormField(
                        obscureText: hide,
                        onChanged: (value) => password = value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              hide ? Icons.visibility : Icons.visibility_off,
                              color: Colors.purple[100],
                            ),
                            onPressed: () {
                              hide = !hide;
                              setState(() {});
                            },
                          ),
                          label: Text('Password'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AuthController.login(email, password, context);
                        },
                        child: Text("Login"),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupWidget(),
                                    ),
                                  );
                                },
                                child: Text("Signup"),
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

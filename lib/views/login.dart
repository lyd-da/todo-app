import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Column(
          children: [
            Row(
              children: [
                Icon(Icons.email, color: Colors.pink[100]),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'email',
                    ),
                  ),
                ),
              ],
            ),
            Card(
              child:
                ListTile(
                  leading: Icon(Icons.email),
                )
              ,
            ),
          ],
        ),
      ),
    );
  }
}

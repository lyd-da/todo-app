import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/task.dart';
import 'package:todo_app/views/task.dart';
import 'model/task.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TaskList()..getAll(),
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.pink[100],
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.pink[100],
              // foregroundColor: Colors.pink[100],
            ),
          ),
          home: HomePage(),
        ));
  }
}

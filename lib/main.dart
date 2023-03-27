import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pink[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink[100],
          // foregroundColor: Colors.pink[100],
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSelected = false;
  String input = '';
  String search = '';
  List<Task> tasks = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // leading: Drawer(),
          title: Text('TODO List'),
        ),
        backgroundColor: Colors.blueGrey[50],
        drawer: Drawer(width: 250.0),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            search = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text(
                  'All TODOs',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...tasks.reversed
                  .where((element) => element.task.contains(search))
                  .map((e) => Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Checkbox(
                                value: e.isSelected,
                                onChanged: (bool? value) {
                                  final task = tasks.firstWhere(
                                      (element) => element.id == e.id);
                                  setState(() {
                                    task.isSelected = value as bool;
                                  });
                                }),
                            Text(
                              e.task,
                              style: TextStyle(
                                  fontSize: 20,
                                  decoration: e.isSelected
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            Spacer(),
                            IconButton(
                              tooltip: 'Delete',
                              onPressed: () {
                                tasks.removeWhere(
                                    (element) => element.id == e.id);
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ))
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    onChanged: (val) {
                      setState(() {
                        input = val;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add new',
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    tasks.add(Task(id: Random().nextInt(10), task: input));
                    controller.clear();
                    setState(() {});
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.pink[100],
                    ),
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



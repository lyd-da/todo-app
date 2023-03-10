import 'package:flutter/material.dart';

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
        body: Column(
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
            Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Checkbox(
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          isSelected = value!;
                        });
                        if(isSelected){
                          
                        }
                      }),
                  Text(
                    'First Task',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  IconButton(
                    tooltip: 'Delete',
                    onPressed: () {
                      print('Delete clicked');
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: CheckboxListTile(
                title: const Text('Animate Slowly'),
                onChanged: (bool? value) {},
                secondary: const Icon(Icons.hourglass_empty),
                value: false,
              ),
            ),
            // Card(
            //   margin: EdgeInsets.all(15),
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20)),
            //   child: Row(
            //     children: [
            //       Checkbox(value: false, onChanged: (bool? checked) {}),
            //       Text(
            //         'Third Task',
            //         style: TextStyle(fontSize: 20),
            //       ),
            //       Spacer(),
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(Icons.delete, color: Colors.red),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add new',
                  ),
                ),
              ),
              IconButton(
                iconSize: 40,
                onPressed: () {},
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
    );
  }
}

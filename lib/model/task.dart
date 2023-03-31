import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  dynamic id;
  bool isSelected;
  String task;
  Task({required this.id, required this.task, this.isSelected = false});
  Map<String, dynamic> toJson() {
    return {"id": id, "isSelected": isSelected, "task": task};
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'], isSelected: json['isSelected'], task: json['task']);
  }
}

class TaskList extends ChangeNotifier {
  final List<Task> _taskList = [];
  var db = FirebaseFirestore.instance;
  List<Task> get tasks => _taskList;
  void add(Task task) async {
    // _taskList.add(task);
    await db.collection("tasks").add(task.toJson());
    _taskList.add(task);
    notifyListeners();
  }

  void remove(Task task) async {
    // _taskList.remove(task);
    await db
        .collection("tasks")
        .where("id", isEqualTo: task.id)
        .get()
        .then((value) => value.docs[0].reference.delete());
    _taskList.remove(task);
    notifyListeners();
  }

  Future<void> getAll() async {
    final list = await db.collection("tasks").get().then(
        (value) => value.docs.map((e) => Task.fromJson(e.data())).toList());
    _taskList.addAll(list);
    notifyListeners();
  }

  void completed(Task task) async {
    await db
        .collection("tasks")
        .doc(task.id.toString())
        .update({"isSelected": "false"});
    task.isSelected = !task.isSelected;
    notifyListeners();
  }
}

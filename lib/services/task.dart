import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task.dart';

class TaskServices {
  var db = FirebaseFirestore.instance;

   Future<void> addTask(Task task) async {
    await db.collection("tasks").add(task.toJson());
  }

  Future<List<Task>> getAllTasks() async {
    final list = await db.collection("tasks").get().then(
        (value) => value.docs.map((e) => Task.fromJson(e.data())).toList());
    return list;
  }

  Future<void>  removeTask(Task task) async {
    await db
        .collection("tasks")
        .where("id", isEqualTo: task.id)
        .get()
        .then((value) => value.docs[0].reference.delete());
  }

  Future<void>  completedTask(Task task) async {
    await db.collection("tasks").where("id", isEqualTo: task.id).get().then(
        (value) => value.docs[0].reference.update({"isSelected": !task.isSelected}));
  }
}

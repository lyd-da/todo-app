import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task.dart';

class TaskServices {
  var db = FirebaseFirestore.instance;

  void addTask(Task task) async {
    await db.collection("tasks").add(task.toJson());
  }

  void removeTask(Task task) async {
    await db
        .collection("tasks")
        .where("id", isEqualTo: task.id)
        .get()
        .then((value) => value.docs[0].reference.delete());
  }

  Future<void> getAllTasks() async {
    final list = await db.collection("tasks").get().then(
        (value) => value.docs.map((e) => Task.fromJson(e.data())).toList());
    // return list;
  }

  void completedTask(Task task) async {
    await db
        .collection("tasks")
        .doc(task.id.toString())
        .update({"isSelected": "false"});
  }
}

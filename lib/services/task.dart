import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/services/database.dart';

import '../model/task.dart';

class TaskServices {
  var db = FirebaseFirestore.instance;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Future<void> addTask(Task task) async {
    await _dbHelper.insertTodo(task);
  }

  Future<List<Task>> getAllTasks() async {
    final list = await _dbHelper.getTodos();
    // await db.collection("tasks").get().then(
    //     (value) => value.docs.map((e) => Task.fromJson(e.data())).toList());
    return list;
  }

  Future<void> removeTask(Task task) async {
    await _dbHelper.deleteTodo(task.id);
  }

  Future<void> completedTask(Task task) async {
    // await db.collection("tasks").where("id", isEqualTo: task.id).get().then(
    //     (value) => value.docs[0].reference.update({"isSelected": !task.isSelected}));

    task.isSelected = !task.isSelected;
    await _dbHelper.updateTodo(task);
  }
}

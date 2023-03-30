import 'package:flutter/material.dart';

class Task {
  dynamic id;
  bool isSelected;
  String task;
  Task({required this.id, required this.task, this.isSelected = false});
}

class TaskList extends ChangeNotifier {
  final List<Task> _taskList = [];

  List<Task> get tasks => _taskList;
  void add(Task task) {
    _taskList.add(task);
    notifyListeners();
  }

  void remove(Task task) {
    _taskList.remove(task);
    notifyListeners();
  }

  void completed(Task task) {
    task.isSelected = !task.isSelected;
    notifyListeners();
  }
}

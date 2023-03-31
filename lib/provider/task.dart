import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/services/task.dart';

class TaskList extends ChangeNotifier {
  final List<Task> _taskList = [];
  
  List<Task> get tasks => _taskList;
  TaskServices services= TaskServices();
  void add(Task task) async {
    // _taskList.add(task);
    services.addTask(task);
    _taskList.add(task);
    notifyListeners();
  }

  void remove(Task task) async {
    // _taskList.remove(task);
    services.removeTask(task);
    _taskList.remove(task);
    notifyListeners();
  }

  Future<void> getAll() async {
    
    // _taskList.addAll(await services.getAllTasks());
    notifyListeners();
  }

  void completed(Task task) async {
    services.completedTask(task);
    task.isSelected = !task.isSelected;
    notifyListeners();
  }
}

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

import 'dart:convert';

class Task {
  String title;
  bool isDone;

  // Constructor
  Task({required this.title, this.isDone = false});

  // 1. Convert a Task object into a Map (to save as JSON)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  // 2. Convert a Map (from JSON) back into a Task object
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      isDone: map['isDone'],
    );
  }
}
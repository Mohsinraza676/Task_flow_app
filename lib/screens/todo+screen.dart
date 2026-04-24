import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Task> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? taskString = prefs.getString('tasks');
    if (taskString != null) {
      List decode = json.decode(taskString);
      setState(() {
        _tasks = decode.map((m) => Task.fromMap(m)).toList();
      });
    }
  }

  _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encode = json.encode(_tasks.map((t) => t.toMap()).toList());
    prefs.setString('tasks', encode);
  }

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(title: _controller.text));
        _controller.clear();
      });
      _saveTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Enter task name", border: OutlineInputBorder()),
                  ),
                ),
                IconButton(onPressed: _addTask, icon: Icon(Icons.add_box, size: 40, color: Colors.blue)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ListTile(
                    title: Text(_tasks[index].title),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() => _tasks.removeAt(index));
                        _saveTasks();
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
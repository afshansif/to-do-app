import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/new_task.dart';
import 'package:todo_app/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasksList = [];

  void _addTask(Task task) {
    setState(() {
      _tasksList.add(task);
    });
  }

  void _removeTask(Task task, int index) {
    setState(() {
      _tasksList.remove(task);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Task Deleted!"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _tasksList.insert(index, task);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => NewTask(
                        onAddTask: _addTask,
                      )));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: TaskList(
          tasksList: _tasksList,
          onRemoveTask: _removeTask,
        ),
      ),
    );
  }
}

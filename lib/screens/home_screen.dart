import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/user_tasks.dart';
import 'package:todo_app/screens/new_task.dart';
import 'package:todo_app/widgets/task_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // List<Task> _tasksList = [];
  late Future<void> _tasksFuture;

@override
  void initState() {
    super.initState();
    // Load the tasks from the database when the app starts or reloads
    _tasksFuture = ref.read(userTasksProvider.notifier).loadTasks();
  }

  void _removeTask(Task task) async {
    final response =
        await ref.watch(userTasksProvider.notifier).deleteTask(task.id);
    if (response != 0) {
      _showSnackbar("Task Deleted!");
    } else {
      _showSnackbar("Something went wrong! Please try again.");
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // gives list that's in provider
    final tasksList = ref.watch(userTasksProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const NewTask()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder(
            future: _tasksFuture,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : TaskList(
                      tasksList: tasksList,
                      onRemoveTask: _removeTask,
                    );
            },
          )),
    );
  }
}

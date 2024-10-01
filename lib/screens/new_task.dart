import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.onAddTask});

  final void Function(Task task) onAddTask;

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _saveEntries() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      showDialog(
          context: context,
          builder: ((ctx) => AlertDialog(
                title: const Text("Invalid Entries!"),
                content: const Text(
                    "Please make sure title or description is not empty."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
              )));
      return;
    } else {
      widget.onAddTask(
        Task(
            title: _titleController.text,
            description: _descriptionController.text),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add new task",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Enter Title"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Enter Description"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _saveEntries,
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

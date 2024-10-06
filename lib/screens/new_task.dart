import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/user_tasks.dart';

class NewTask extends ConsumerStatefulWidget {
  const NewTask({
    super.key,
  });

  @override
  ConsumerState<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends ConsumerState<NewTask> {
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
      // Correctly accessing ref to update the state
      ref.read(userTasksProvider.notifier).addTasks(
            _titleController.text,
            _descriptionController.text,
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

import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/task_card.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasksList,
    required this.onRemoveTask,
  });

  final List<Task> tasksList;
  final void Function(Task task) onRemoveTask;

  @override
  Widget build(BuildContext context) {
    if (tasksList.isEmpty) {
      return Center(
        child: Text(
          'No Tasks added yet.',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      );
    }
    return ListView.builder(
      itemCount: tasksList.length,
      itemBuilder: (ctx, index) {
        return Dismissible(
          key: ValueKey(tasksList[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.4),
          ),
          onDismissed: (direction) {
            onRemoveTask(tasksList[index]);
          },
          child: TaskCard(
            task: tasksList[index],
          ),
        );
      },
    );
  }
}

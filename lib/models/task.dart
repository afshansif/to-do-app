import 'package:uuid/uuid.dart';

class Task {
  final String title;

  final String description;
  final String id;

  Task({
    required this.title,
    required this.description,
    String? id,
  }) : id = id ?? const Uuid().v4();
}

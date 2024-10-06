import 'package:riverpod/riverpod.dart';
import 'package:todo_app/models/task.dart';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart' as syspath;

class UserTasksNotifier extends StateNotifier<List<Task>> {
  UserTasksNotifier() : super([]);

  Future<Database> _getDataBase() async {
    //creating database to store data permanently
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, "tasks.dp"),
      onCreate: ((db, version) {
        return db.execute(
            "CREATE TABLE user_tasks(id TEXT PRIMARY KEY, title TEXT, description TEXT)");
      }),
      version: 1,
    );
    return db;
  }

  Future<void> loadTasks() async {
    //loading data from database
    final db = await _getDataBase();
    final data = await db.query("user_tasks");
    final tasks = data
        .map(
          (row) => Task(
            id: row['id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
          ),
        )
        .toList();
    state = tasks;
  }

  void addTasks(String title, String description) async {
    //final appDir = await syspath.getApplicationDocumentsDirectory();

    //adding data to database

    final newTasks = Task(title: title, description: description);
    final db = await _getDataBase();
    db.insert('user_tasks', {
      "id": newTasks.id,
      "title": newTasks.title,
      "description": newTasks.description,
    });

    state = [newTasks, ...state];
  }
  Future<int> deleteTask(String id) async {
    final db = await _getDataBase();
    final result = await db.delete(
      'user_tasks',
      where: 'id = ?',
      whereArgs: [id],
    );

    // Update the state by removing the deleted place from the state list
    if (result != 0) {
      state = state.where((place) => place.id != id).toList();
    }
    
    return result;
  }

  
}



final userTasksProvider =
      StateNotifierProvider<UserTasksNotifier, List<Task>>(
    (ref) => UserTasksNotifier(),
  );

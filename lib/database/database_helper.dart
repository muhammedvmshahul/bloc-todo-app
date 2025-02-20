import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/task_model.dart';

/// Helper class for handling SQLite database operations.
class DatabaseHelper {
  static Database? _database; // Database instance (singleton pattern)

  /// Returns the database instance, initializes it if null.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initializes and opens the SQLite database.
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db'); // Get database path
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create the 'tasks' table when database is first created
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            isCompleted INTEGER
          )
        ''');
      },
    );
  }

  /// Adds a new task to the database.
  Future<int> addTask(Task task) async {
    final db = await database; // Get database instance
    return await db.insert('tasks', task.toMap()); // Insert task into 'tasks' table
  }

  /// Retrieves all tasks from the database.
  Future<List<Task>> getTasks() async {
    final db = await database; // Get database instance
    List<Map<String, dynamic>> maps = await db.query('tasks'); // Fetch all tasks
    return List.generate(maps.length, (i) => Task.fromMap(maps[i])); // Convert to Task list
  }

  /// Updates an existing task in the database.
  Future<int> updateTask(Task task) async {
    final db = await database; // Get database instance
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id], // Update based on task ID
    );
  }

  /// Deletes a task from the database by ID.
  Future<int> deleteTask(int id) async {
    final db = await database; // Get database instance
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id], // Delete based on task ID
    );
  }
}

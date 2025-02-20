import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/database_helper.dart';
import '../model/task_model.dart';

/// BLoC class for managing tasks.
/// Uses `Cubit<List<Task>>` to handle the state of the task list.
class TaskBloc extends Cubit<List<Task>> {
  final DatabaseHelper databaseHelper; // Database helper instance

  /// Constructor initializes the database and loads tasks.
  TaskBloc(this.databaseHelper) : super([]) {
    loadTasks();
  }

  /// Loads all tasks from the database and updates the UI.
  void loadTasks() async {
    final tasks = await databaseHelper.getTasks(); // Fetch tasks from database
    emit(tasks); // Emit the updated task list to the UI
  }

  /// Adds a new task to the database and refreshes the task list.
  void addTask(Task task) async {
    await databaseHelper.addTask(task); // Insert task into database
    loadTasks(); // Reload tasks after adding
  }

  /// Updates an existing task in the database and refreshes the UI.
  void updateTask(Task task) async {
    await databaseHelper.updateTask(task); // Update task details
    loadTasks(); // Reload tasks after updating
  }

  /// Deletes a task from the database and updates the UI.
  void deleteTask(int id) async {
    await databaseHelper.deleteTask(id); // Remove task from database
    loadTasks(); // Reload tasks after deletion
  }

  /// Toggles the completion status of a task and updates the UI.
  void toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted; // Flip the completed status
    await databaseHelper.updateTask(task); // Save changes to database
    loadTasks(); // Reload tasks after updating status
  }
}

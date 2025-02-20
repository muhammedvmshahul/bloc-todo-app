import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/database_helper.dart';
import '../model/task_model.dart';

class TaskBloc extends Cubit<List<Task>> {
  final DatabaseHelper databaseHelper;

  TaskBloc(this.databaseHelper) : super([]) {
    loadTasks();
  }

  void loadTasks() async {
    final tasks = await databaseHelper.getTasks();
    emit(tasks);
  }

  void addTask(Task task) async {
    await databaseHelper.addTask(task);
    loadTasks();
  }

  void updateTask(Task task) async {
    await databaseHelper.updateTask(task);
    loadTasks();
  }

  void deleteTask(int id) async {
    await databaseHelper.deleteTask(id);
    loadTasks();
  }

  void toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await databaseHelper.updateTask(task);
    loadTasks();
  }
}

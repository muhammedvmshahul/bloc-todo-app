import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/utils/height_and_width.dart';
import '../bloc/task_bloc.dart';
import '../model/task_model.dart';
import 'add_screen.dart';
import 'edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("To-Do List",
              style: TextStyle(
                color: Colors.white,
              ))),
      body: BlocBuilder<TaskBloc, List<Task>>(
        builder: (context, tasks) {
          if (tasks.isEmpty) {
            return Center(
                child: Text(
              "No tasks available",
              style: TextStyle(color: Colors.white),
            ));
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
                child: Container(
                  width: width * 1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: task.isCompleted,
                          onChanged: (_) => taskBloc.toggleTaskCompletion(task),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.black),
                          // Edit button
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditTaskScreen(task: task),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          // Delete button
                          onPressed: () {
                            taskBloc.deleteTask(task.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTaskScreen()),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

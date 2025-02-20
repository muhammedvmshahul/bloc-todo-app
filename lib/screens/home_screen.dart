import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/utils/height_and_width.dart';
import '../bloc/task_bloc.dart';
import '../model/task_model.dart';
import 'add_screen.dart';
import 'edit_screen.dart';

/// Home screen displaying the list of tasks.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context); // Access TaskBloc

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "To-Do List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<TaskBloc, List<Task>>(
        builder: (context, tasks) {
          if (tasks.isEmpty) {
            return Center(
              child: Text(
                "No tasks available", // Message when no tasks are available
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return ListView.builder(
            itemCount: tasks.length, // Number of tasks in the list
            itemBuilder: (context, index) {
              final task = tasks[index];

              return Padding(
                padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 10, bottom: 10,
                ),
                child: Container(
                  width: width * 1, // Full width container
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: ListTile(
                    title: Text(task.title), // Task title
                    subtitle: Text(task.description), // Task description
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Checkbox to mark task as completed
                        Checkbox(
                          value: task.isCompleted,
                          onChanged: (_) => taskBloc.toggleTaskCompletion(task),
                        ),

                        /// Edit button to modify the task
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTaskScreen(task: task),
                              ),
                            );
                          },
                        ),

                        /// Delete button to remove the task
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
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

      /// Floating Action Button to add a new task
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

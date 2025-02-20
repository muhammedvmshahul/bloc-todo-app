import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/utils/height_and_width.dart';
import '../bloc/task_bloc.dart';
import '../model/task_model.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void _addTask(BuildContext context) {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Title cannot be empty!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final task = Task(
      title: title,
      description: description.isNotEmpty ? description : "No description",
    );
    BlocProvider.of<TaskBloc>(context).addTask(task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("Add Task",
              style: TextStyle(
                color: Colors.white,
              ))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: height * 0.1),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                labelText: "Title",
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: height * 0.02),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: height * 0.03),
            GestureDetector(
                onTap: () => _addTask(context),
                child: Container(
                  height: height * 0.05,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(6)),
                  child: Center(
                    child: Text(
                      'Add Task',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

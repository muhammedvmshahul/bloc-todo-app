import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../model/task_model.dart';
import '../utils/height_and_width.dart';

/// Screen for editing an existing task.
class EditTaskScreen extends StatefulWidget {
  final Task task; // Task to be edited

  const EditTaskScreen({super.key, required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  /// Initialize controllers with the existing task details
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context); // Get TaskBloc instance

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white), // White back button
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Edit Task",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: height * 0.1), // Adds spacing from top

            /// Title Input Field
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                labelText: "Title",
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),

            SizedBox(height: height * 0.02), // Spacing

            /// Description Input Field
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),

            SizedBox(height: height * 0.03), // Spacing

            /// Edit Task Button
            GestureDetector(
              onTap: () {
                // Create an updated Task object with new input values
                Task updatedTask = Task(
                  id: widget.task.id,
                  title: titleController.text,
                  description: descriptionController.text,
                  isCompleted: widget.task.isCompleted, // Keep completion status unchanged
                );

                // Update the task in BLoC
                taskBloc.updateTask(updatedTask);

                // Navigate back to the previous screen
                Navigator.pop(context);
              },
              child: Container(
                height: height * 0.05,
                width: width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

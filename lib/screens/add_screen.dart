import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/utils/height_and_width.dart';
import '../bloc/task_bloc.dart';
import '../model/task_model.dart';

/// Screen for adding a new task.
class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  // Controllers to handle user input
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  /// Function to validate input and add a new task
  void _addTask(BuildContext context) {
    String title = titleController.text.trim(); // Get title text
    String description = descriptionController.text.trim(); // Get description text

    if (title.isEmpty) {
      // Show an error message if the title is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Title cannot be empty!"), // Display error message
          backgroundColor: Colors.red, // Red color to indicate error
        ),
      );
      return; // Stop further execution
    }

    // Create a new Task object
    final task = Task(
      title: title,
      description: description.isNotEmpty ? description : "No description", // Default description if empty
    );

    // Add the task to the BLoC state
    BlocProvider.of<TaskBloc>(context).addTask(task);

    // Close the Add Task screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white), // White back button
        backgroundColor: Colors.black, // AppBar background
        centerTitle: true,
        title: Text(
          "Add Task",
          style: TextStyle(color: Colors.white), // White text color
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
                  borderSide: BorderSide(color: Colors.white, width: 1), // White border when not focused
                ),
                labelText: "Title", // Placeholder label
                labelStyle: TextStyle(color: Colors.grey), // Grey text
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1), // White border when focused
                ),
              ),
              style: TextStyle(color: Colors.white), // White text color inside TextField
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

            /// Add Task Button
            GestureDetector(
              onTap: () => _addTask(context), // Calls _addTask function
              child: Container(
                height: height * 0.05,
                width: width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.pink, // Button background color
                  borderRadius: BorderRadius.circular(6), // Rounded corners
                ),
                child: Center(
                  child: Text(
                    'Add Task',
                    style: TextStyle(
                      color: Colors.white, // White text
                      fontWeight: FontWeight.bold, // Bold text
                    ),
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

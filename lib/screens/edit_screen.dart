import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../model/task_model.dart';
import '../utils/height_and_width.dart';


class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("Edit Task", style: TextStyle(
                color: Colors.white,
              ))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: height*0.1),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                labelText: "Title",
                labelStyle: TextStyle(color: Colors.grey,),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
              ),

              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: height*0.02),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                labelStyle: TextStyle(color: Colors.grey,),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: height*0.03),
            GestureDetector(
              onTap: () {
                Task updatedTask = Task(
                  id: widget.task.id,
                  title: titleController.text,
                  description: descriptionController.text,
                  isCompleted: widget.task.isCompleted,
                );
                taskBloc.updateTask(updatedTask);
                Navigator.pop(context);
              },
              child: Container(
                height: height*0.05,
                width: width*0.3,
                decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius:BorderRadius.circular(6)
                ),
                child: Center(
                  child: Text('Edit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Classes/TaskProvider.dart';
import '../Classes/Task.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  AddTaskState createState() => AddTaskState();
}


class AddTaskState extends State<AddTask> {
  String taskText = "Hello World";
  final taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity, //this makes it take up the whole space in the container
          padding: EdgeInsets.symmetric(
          //padding of text in container
            vertical: 10.0,
            horizontal: 10.0),

      margin: EdgeInsets.only(
        top: 20.0,
        //bottom: 10.0    //Change the distance between two containers 
      ),
      decoration: BoxDecoration(
        //Change the color and the rounded edges and add 50% opacity 
        color: Colors.red[800].withOpacity(0.5), 
        borderRadius: BorderRadius.circular(20.0)),
      
      child: TextField(
          onSubmitted: (value) {
              //This will access the provider and call our add task function everytime we hit enter 
              context.read<TaskProvider>().addTask(Task(value));
          },
          controller: taskController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter a task',
            prefixIcon: Icon(Icons.add_circle, size: 25)
        ),
      )
    );
  }
}
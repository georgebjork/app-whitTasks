

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Classes/TaskProvider.dart';
import '../Classes/Task.dart';
import 'package:provider/provider.dart';
import '../Classes/httpService.dart';

class AddTask extends StatefulWidget {

  AddTaskState createState() => AddTaskState();
}


class AddTaskState extends State<AddTask> {
  final httpService service = httpService();
  final taskController = TextEditingController();
  final String defaultText = "Enter a task";
  httpService h;
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
        color: Theme.of(context).cardColor, 
        borderRadius: BorderRadius.circular(20.0)),
      
      child: TextField(
          onSubmitted: (value) async{
              //This will access the provider and call our add task function everytime we hit enter 
              //It will check to see if the string is empty. Returns true if it is 
              if(value.isEmpty == false)
              {
                //This will give the task to the provider and the provider will post it to the api
                taskController.clear();
                await context.read<TaskProvider>().addTask(value);
                
              }
          },
          controller: taskController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: defaultText,
            hintStyle: TextStyle(fontSize: 20, color: Colors.white),
            prefixIcon: Icon(Icons.add, size: 30, color: Colors.white)
        ),
      )
    );
  }
}
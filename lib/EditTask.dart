import 'dart:core';


import 'package:app_whittasks/Classes/TaskProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'Classes/Task.dart';
import 'Classes/httpService.dart';
import 'Widgets/CheckMarkBox.dart';
import 'Classes/ThemeProvider.dart';

class EditTask extends StatefulWidget{

  Task task;
  EditTask(this.task);

  @override 
  EditTaskState createState() => EditTaskState(task);

}

class EditTaskState extends State<EditTask>{
  Task task;
  EditTaskState(this.task);

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(elevation: 0.0, title: Text("Details"), backgroundColor: Theme.of(context).accentColor,),
      body: Container(
        color: Theme.of(context).accentColor,
        width: double.infinity,
         child: Consumer<TaskProvider>(
           builder:  (context, provider, child) {
           return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget> [
              Title(task),
              SizedBox(height: 40),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 30.0, right: 16.0, top: 30.0),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(topRight: Radius.circular(36), topLeft: Radius.circular(36))),
                  child: Column(
                    children: [
                      Status(task),
                      SizedBox(height: 20),
                      DueDate(task),
                    ],
                  ),
                ),
              ),
            ],
           );
           }
         )
      ),
    );
  }
}

class Title extends StatefulWidget{
  Task task;
  Title(this.task);
  @override
  TitleState createState() =>TitleState(task);
}

class TitleState extends State<Title>{

  Task task;
  TitleState(this.task);
  final taskController = TextEditingController();
  
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
       padding: EdgeInsets.only(left: 30.0, right: 16.0, top: 30),
        child: TextField(
          controller: taskController,
          style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: task.task,
            hintStyle: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            taskController.text = task.task;
            FocusScopeNode currentFocus = FocusScope.of(context);
            //print("focus");
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
              print(taskController.text);
              //print("Unfocus");
              //context.read<TaskProvider>().update(task);
            }
          },

          textInputAction: TextInputAction.go,
            onSubmitted: (text) {
              task.task = text;
              context.read<TaskProvider>().update(task);
            },
        )
        //Text(task.task, style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
      );
    
    //Text(task.task, style: TextStyle(color: Colors.white, fontSize: 18,));
  }

  
}

class DueDate extends StatelessWidget{
  Task task;
  DueDate(this.task);

  String getDate(){
    var due_date = DateTime.parse(task.date);
    if(DateFormat.yMMMMd('en_US').format(due_date) == DateFormat.yMMMMd('en_US').format(DateTime.now()))
    {
      return "Today";
    }
    return DateFormat('EEEE,  MMMM d').format(due_date).toString();
  }
  

  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.calendar_today_sharp, color: Colors.grey, size: 20 ),
          SizedBox(width: 12),
          Text(getDate(), style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}

class Status extends StatelessWidget{
  Task task; 
  Status(this.task);

  Widget build(BuildContext context){
    return Container(
      child: Row(
        children: [
          CheckMarkBox(task),
          SizedBox(width: 12),
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),  
            curve: Curves.fastOutSlowIn, 
            child: Text(task.isDone ? "Completed" : "Not Completed",  style: TextStyle(fontSize: 20))
          ),
        ],
      ),
    );
  }
}
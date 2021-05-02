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

         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
            Title(task),
            SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 30.0, right: 16.0, top: 30.0),
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25))),
                child: Column(
                  children: [
                    DueDate(task),
                  ],
                ),
              ),
            ),
          ],
         )
      ),
    );
  }
}

class Title extends StatelessWidget{
  Task task;
  Title(this.task);

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
       padding: EdgeInsets.only(left: 30.0, right: 16.0, top: 30),
        child: Text(task.task, style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
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
          Icon(Icons.calendar_today_sharp, color: Colors.white, size: 20 ),
          SizedBox(width: 10),
          Text(getDate(), style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}
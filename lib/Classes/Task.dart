import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:core';


class Task{

  int task_id;
  int user_id = 0;
  String task = "";
  String date;
  DateTime due_date;
  String details;
  bool isDone = false;


  Task(this.task, this.date, this.user_id, this.task_id, this.isDone); 
  
  Task.tempTask(this.task);

  Task.fromTask({
    @required this.task,
    @required this.date,
    @required this.user_id,
    @required this.task_id,
    @required this.isDone
  });


  set setTask(String t){
    task = t;
  }

  String getTask() {
    return task;
  }

  DateTime getDueDate(){
    return due_date;
  }

  String getFormattedDate(){
    due_date = DateTime.parse(date);
    if(DateFormat.yMMMMd('en_US').format(due_date) == DateFormat.yMMMMd('en_US').format(DateTime.now()))
    {
      return "Today";
    }   
    return DateFormat('EEEE, MMMM d').format(due_date).toString();
  }

  String getDate(){
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String nowString = formatter.format(now);

    due_date = DateTime.parse(date);
    String dateString = formatter.format(due_date);

    if(dateString == nowString){
      return dateString;
    }
    return dateString;
    // 2016-01-25
  }

  String getDetails(){
    return details;
  }

  bool getState(){
    return isDone;
  }

  bool isToday(){
    if(date == "Today")
      return true;
    
    return false; 
  }

  void changeState(){
    isDone = !isDone;
  }

  factory Task.fromJson(Map<String, dynamic> json)
  {
    print(json['name'] as String);
    return Task.fromTask(
      task: json['name'] as String,
      date: json['due_date'] as String,
      user_id : json['user_id'] as int,
      task_id: json['task_id'] as int,
      isDone: json['done'] as bool,
    );
  }

  
}


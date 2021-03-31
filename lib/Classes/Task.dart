import 'package:flutter/cupertino.dart';

class Task{

  int id;
  int user_id;
  String task = "";
  String date = "";
  String details = "Details will be added soon";
  bool isDone = false;


  Task(this.task, this.date); 

  Task.fromTask({
    @required this.task,
    @required this.date
  });


  
  set setTask(String t){
    task = t;
  }

  String getTask() {
    return task;
  }

  String getDate(){
    return date;
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
      date: "MyDay"
    );
  }

  
}


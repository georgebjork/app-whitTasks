import 'package:flutter/cupertino.dart';

class Task{

  int task_id;
  int user_id = 0;
  String task = "";
  String date = "";
  String details = "Details will be added soon";
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
      date: "MyDay",
      user_id : json['user_id'] as int,
      task_id: json['task_id'] as int,
      isDone: json['done'] as bool

    );
  }

  
}


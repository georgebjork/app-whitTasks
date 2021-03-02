import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class Task{

  String task = "";
  
  Task(String t) {
    task = t;
  }
  
  set setTask(String t){
    task = t;
  }

  get getTask {
    return task;
  }
  
}


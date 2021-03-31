import 'package:flutter/material.dart';
import 'httpService.dart';


import 'Task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> tasks = [];
  List<Task> completedTasks = [];

  Future<Task> futureTask;

  void addTask(Task t) {
    tasks.add(t);
    notifyListeners();
  }

  void removeTask(Task t) {
    tasks.remove(t);
    //completedTasks.add(t);
    notifyListeners();
  }

  void removeAtIndex(int index){
    tasks.removeAt(index);
    notifyListeners();
  }

  void update(){
    notifyListeners();
  }
}

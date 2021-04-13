import 'package:flutter/material.dart';
import 'httpService.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';


import 'Task.dart';

class TaskProvider with ChangeNotifier {

  final httpService service = httpService();
  
  List<Task> tasks = List<Task>();

  Future<void> addTask(String task) async {
    await service.createTask(task);
    tasks = await service.getTask();
    notifyListeners();
  }

  Future<void> getTasks() async{
    tasks = await service.getTask();
  }


  Future<void> removeTask(Task t) async {
    tasks.remove(t);
    await service.deleteTask(t);
    //completedTasks.add(t);
    notifyListeners();
  }

  void removeAtIndex(int index){
    tasks.removeAt(index);
    notifyListeners();
  }

  Future<void> update(Task t) async{
    await service.updateTask(t);
    notifyListeners();
  }
}

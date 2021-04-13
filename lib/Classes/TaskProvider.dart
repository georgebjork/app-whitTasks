import 'package:flutter/material.dart';
import 'httpService.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';


import 'Task.dart';

class TaskProvider with ChangeNotifier {

  final httpService service = httpService();
  
  List<Task> tasks = List<Task>();

  Future<void> addTask(String taskName) async {
    //addLocalTask(taskName);
    //Add a small buffer time
    //await Future.delayed(Duration(seconds: 1));

    await service.createTask(taskName);
    tasks = await service.getTask();
    notifyListeners();
  }

  void addLocalTask(String taskName){
    tasks.add(Task.tempTask(taskName));
    notifyListeners();
  }

  Future<List<Task>> getTasks() async{
    return tasks = await service.getTask();
  }


  Future<void> removeTask(Task t) async {
    tasks.remove(t);
    await service.deleteTask(t);
    notifyListeners();
  }

  Future<void> update(Task t) async{
    await service.updateTask(t);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'httpService.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';


import 'Task.dart';
import 'User.dart';

class TaskProvider with ChangeNotifier {

  final httpService service = httpService();
  User user;
  
  List<Task> tasks = List<Task>();

  Future<void> addTask(String taskName) async {
    //addLocalTask(taskName);
    //Add a small buffer time
    //await Future.delayed(Duration(seconds: 1));
    
    //Create a new task
    await service.createTask(taskName, user);
    //Get the updated task by calling get task
    tasks = await service.getTask(user);
    notifyListeners();
  }

  void addLocalTask(String taskName){
    tasks.add(Task.tempTask(taskName));
    notifyListeners();
  }

  Future<List<Task>> getTasks() async{
    return tasks = await service.getTask(user);
  }


  Future<void> removeTask(Task t) async {
    tasks.remove(t);
    service.deleteTask(t).then((v) { notifyListeners(); });
  }

  Future<void> update(Task t) async{
    await service.updateTask(t, user);
    notifyListeners();
  }

  void addUser(String body){
    var userJson = jsonDecode(body);
    User u = User.fromJson(userJson);
    user = u;
  }
}

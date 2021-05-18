import 'package:flutter/material.dart';
import 'httpService.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';


import 'Task.dart';
import 'User.dart';

class TaskProvider with ChangeNotifier {

  //httpService object to talk to api
  final httpService service = httpService();

  //This will be our local user
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
    //Add a local task
    tasks.add(Task.tempTask(taskName));
    //Update
    notifyListeners();
  }

  Future<List<Task>> getTasks() async{
    //This will return all the tasks from the api
    return tasks = await service.getTask(user);
  }


  Future<void> removeTask(Task t) async {
    //Remove the task locally 
    tasks.remove(t);
    //Delete and once deleted rebuild
    service.deleteTask(t).then((v) { notifyListeners(); });
  }

  Future<void> update(Task t) async{
    //update the task in the api
    await service.updateTask(t, user);
    //update
    print(t.due_date);
    notifyListeners();

  }

  void addUser(String body){
    //get the string and convert to json
    var userJson = jsonDecode(body);
    //create a user
    User u = User.fromJson(userJson);
    //local user is = to the user we made 
    user = u;
  }
}

import 'package:flutter/material.dart';
import 'httpService.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


import 'Task.dart';

class TaskProvider with ChangeNotifier {

  final httpService service = httpService();
  
  List<Task> tasks = List<Task>();

  Future<void> addTask(String task) async {
    await service.createTask(task);
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

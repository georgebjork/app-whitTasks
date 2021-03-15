import 'package:flutter/material.dart';

import 'Task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> tasks = [];

  void addTask(Task t) {
    tasks.add(t);
    notifyListeners();
  }

  void removeTask(Task t) {
    tasks.remove(t);
    notifyListeners();
  }

  void removeAtIndex(int index){
    tasks.removeAt(index);
    notifyListeners();
  }
}

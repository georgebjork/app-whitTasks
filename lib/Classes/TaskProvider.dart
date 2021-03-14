import 'package:flutter/material.dart';

import 'Task.dart';

class TaskProvider with ChangeNotifier{
  List<Task> tasks = [
      Task("hello world"),
      Task("This should be working")
  ];
}
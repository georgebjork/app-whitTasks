import 'dart:async';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'Task.dart';
import 'package:provider/provider.dart';
import '../Classes/TaskProvider.dart';

//This class will handle any interactions with the api

class httpService {
  final String taskUrl = "https://api-whittasks.azurewebsites.net/api/tasks";

  Future<List<Task>> getTask() async {
    Response res = await get(taskUrl);

    //Successful request
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Task> tasks =
          body.map((dynamic item) => Task.fromJson(item)).toList();

      return tasks;

      //return Task.fromJson(jsonDecode(res.body));

    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> createTask(String task) async {
    var data = jsonEncode({'user_id': 1, 'name': task});

    Response res = await post(Uri.encodeFull(taskUrl), body: data, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    return res;
  }

  Future<http.Response> updateTask(Task t) async {
    var data = jsonEncode(
        {'task_id': t.task_id, 'user_id': 1, 'name': t.task, 'done': t.isDone});

    Response res = await put(
        Uri.encodeFull(
            "https://api-whittasks.azurewebsites.net/api/task/update/" +
                t.task_id.toString()),
        body: data,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    return res;
  }
}

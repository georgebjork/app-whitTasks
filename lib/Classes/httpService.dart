import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'Task.dart';
import 'User.dart';
import 'package:provider/provider.dart';
import '../Classes/TaskProvider.dart';

//This class will handle any interactions with the api

class httpService {
  final String taskUrl = "https://api-whittasks.azurewebsites.net/api/";

  Future<List<Task>> getTask(User u) async { 
    Response res = await get(taskUrl + "tasks/" + u.user_id.toString());
    List<Task> tasks = [];
    //Successful request
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      tasks = body.map((dynamic item) => Task.fromJson(item)).toList();

      return tasks;

    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> createTask(String task, User user) async {
    var data = jsonEncode({'user_id': user.user_id, 'name': task});

    Response res = await post(Uri.encodeFull(taskUrl + "tasks"), body: data, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    return res;
  }

  Future<http.Response> updateTask(Task t, User user) async {
    var data = jsonEncode(
        {'task_id': t.task_id, 'user_id': user.user_id, 'name': t.task, 'done': t.isDone, 'due_date': t.due_date.toString()});

    Response res = await put(
        Uri.encodeFull(
            taskUrl + "task/update/" +
                t.task_id.toString()),
        body: data,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    return res;
  }

  Future<http.Response> deleteTask(Task t) async {
    var data = jsonEncode(
        {'task_id': t.task_id,});

      Response res = await delete(
        Uri.encodeFull(
            taskUrl + "task/" +
                t.task_id.toString()),);
    return res;
  }

  Future<http.Response> login(String email, String password) async {
    var data = jsonEncode(
        {'email' : email, 'password' : password});

    Response res = await post(Uri.encodeFull(taskUrl + "users/login"), body: data, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    return res;

  }
}

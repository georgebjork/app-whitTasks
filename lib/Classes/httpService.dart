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

      List<Task> tasks = body.map((dynamic item) => Task.fromJson(item)).toList();

      return tasks;

      //return Task.fromJson(jsonDecode(res.body));

    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> createTask(String task) async {

    var data = jsonEncode( {
      'user_id' : 1, 
      'name' : task
    });

    Response res = await post(Uri.encodeFull(taskUrl), body: data, headers: {
      "Accept": "application/json",
      "content-type":"application/json"
    });
    return res;
  }
}

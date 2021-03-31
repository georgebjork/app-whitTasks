import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'Task.dart';
import 'package:provider/provider.dart';
import '../Classes/TaskProvider.dart';

class httpService {
  final String postUrl = "https://api-whittasks.azurewebsites.net/api/task";

  Future<List<Task>> getPost() async {
    Response res = await get(postUrl);

    //Successful request
    if(res.statusCode == 200)
    {
      
      List<dynamic> body = jsonDecode(res.body);

      List<Task> tasks = body.map((dynamic item) => Task.fromJson(item),).toList();

      return tasks;
      
      //return Task.fromJson(jsonDecode(res.body));
  
    } else {
      throw Exception('Failed to load data');
    }
  }
}
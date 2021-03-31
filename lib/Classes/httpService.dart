import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'Task.dart';
import 'package:provider/provider.dart';
import '../Classes/TaskProvider.dart';

//This class will handle any interactions with the api 

class httpService {
  
  Future<List<Task>> getTask() async {
    
    final String taskUrl = "https://api-whittasks.azurewebsites.net/api/task";

    Response res = await get(taskUrl);

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
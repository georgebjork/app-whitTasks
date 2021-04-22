import 'package:app_whittasks/Calendar.dart';
import 'package:app_whittasks/Classes/TaskProvider.dart';
import 'package:app_whittasks/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyDay.dart';
import 'Calendar.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TaskProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark, 
          primaryColor: Colors.grey[850],
          accentColor: Colors.red[900], 

          //Default font theme
          fontFamily: 'Montserrat',
        ),   
        routes: {
          '/home' : (context) => MyDay(),
          '/calendar' : (context) => Calendar()
        },
        //This will call the my day class and build out the entire page
        home: Login());
  }
}


import 'package:app_whittasks/Calendar.dart';
import 'package:app_whittasks/Classes/Task.dart';
import 'package:app_whittasks/Classes/TaskProvider.dart';
import 'package:app_whittasks/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Classes/ThemeProvider.dart';
import 'MyDay.dart';
import 'Calendar.dart';
import 'EditTask.dart';
import 'Classes/Task.dart';

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
    return ChangeNotifierProvider(create:(context) => ThemeProvider("dark"),
      child: new MaterialAppWithTheme(),
    );
  }
}


class MaterialAppWithTheme extends StatelessWidget{
  Widget build (BuildContext context){
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: theme.getTheme(),
      routes: {
             '/home' : (context) => MyDay(),
             '/calendar' : (context) => Calendar(),
           },
           //This will call the my day class and build out the entire page
      home: Login()
    );
  }
}

// //Current theme 
          
          // // theme: ThemeData(
          // //   //brightness: Brightness.dark, 
          // //   scaffoldBackgroundColor: Color(0xFF2A2B2A),
          // //   primaryColor: Colors.grey[850], //Color(0xFF4B4B4B) 
          // //   accentColor: Colors.red[900], 
    
          // //   //Default font theme
          // //   fontFamily: 'Montserrat',
          // // ),   
          // routes: {
          //   '/home' : (context) => MyDay(),
          //   '/calendar' : (context) => Calendar()
          // },
          // //This will call the my day class and build out the entire page
          // home: Login()

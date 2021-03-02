import 'package:flutter/material.dart';
import 'MyDay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.grey[900], ),   //scaffoldBackgroundColor: Colors.grey[900]
        //This will call the my day class and build out the entire page
        home: MyDay());
  }
}


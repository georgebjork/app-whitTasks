import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'Classes/Task.dart';

import 'Widgets/TaskCardWidget.dart';
import 'Widgets/MyDayHeader.dart';

class MyDay extends StatefulWidget {
  @override
  MyDayState createState() => MyDayState();
}

class MyDayState extends State<MyDay> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,   //This will expand the width of the container to the whole page
        padding: EdgeInsets.all(24.0),
        color: Colors.grey[350],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //This will shift everything to the left
          children: [MyDayHeader(), TaskCardWidget(), TaskCardWidget() ]
        ),
      ),
    );
  }
}

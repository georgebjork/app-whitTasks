import 'package:app_whittasks/Widgets/AddTask.dart';
import 'package:flutter/material.dart';

import 'Widgets/TaskCardWidget.dart';
import 'Widgets/MyDayHeader.dart';
import 'Classes/Task.dart';

class MyDay extends StatefulWidget {
  @override
  MyDayState createState() => MyDayState();
}

class MyDayState extends State<MyDay> {

  //This will be a list of tasks for the list view builder 
  List<Task> tasks = [
      Task("hello world"),
  ];


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0,),
      body: Container(
        width: double.infinity, //This will expand the width of the container to the whole page
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
        color: Colors.grey[900],


        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //This will shift everything to the left
            children: <Widget>[
              MyDayHeader(),
              Expanded( 
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index){
                    return TaskCardWidget(tasks[index]);
                  }
                )
              ),
              Container(alignment: Alignment.bottomLeft, child: AddTask()),
            ]),
      ),
      
        drawer: Drawer(
          child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.red[900],
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}

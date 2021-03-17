import 'package:app_whittasks/Classes/TaskProvider.dart';
import 'package:app_whittasks/Widgets/AddTask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Widgets/TaskCardWidget.dart';
import 'Widgets/MyDayHeader.dart';
import 'Classes/Task.dart';

class MyDay extends StatefulWidget {
  @override
  MyDayState createState() => MyDayState();
}

class MyDayState extends State<MyDay> {

  //This will be a list of tasks for the list view builder 

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
              //Show tasks need to do still 
              Expanded(
                child: Consumer<TaskProvider>(
                  builder: (context, provider, child){
                    //This list view displays a scrollable list of taskcard widgets
                    return  ListView.builder(
                      itemCount: provider.tasks.length,
                      itemBuilder: (context, index){ //Card(elevation: 0, color: Colors.transparent, child: TaskCardWidget(provider.tasks[index]));
                        return Dismissible(
                          background: Container(decoration: BoxDecoration(color: Colors.red[900], borderRadius: BorderRadius.circular(20.0))),
                          resizeDuration: Duration(seconds: 1),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction){
                            setState(() {
                                provider.tasks.removeAt(index);
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Task has been deleted"), duration: Duration(seconds: 3)));
                            });
                          },
                          
                          key: ValueKey(provider.tasks.elementAt(index)),
                          child: TaskCardWidget(provider.tasks[index])
                        );
                      }
                    );  // Card(elevation: 0, color: Colors.transparent, child: TaskCardWidget(provider.tasks[index]))
                  }
                ),
              ),
              //Show all completed tasks 
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

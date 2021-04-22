import 'package:app_whittasks/Classes/TaskProvider.dart';
import 'package:app_whittasks/Widgets/AddTask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

import 'Widgets/TaskCardWidget.dart';
import 'Widgets/MyDayHeader.dart';
import 'Classes/Task.dart';
import 'Classes/httpService.dart';
import 'Calendar.dart';

class MyDay extends StatefulWidget {
  
  @override
  MyDayState createState() => MyDayState();
}

class MyDayState extends State<MyDay> {
  //This will be a list of tasks for the list view builder 
  final httpService service = httpService();
  StreamController<Task> controller = StreamController<Task>();
  List<Task> list; 
  void initState()
  {
    super.initState();
  }

  Stream<List<Task>> getTasks() async* {
    yield await Provider.of<TaskProvider>(context, listen: false).getTasks();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(elevation: 0.0,),
      body: Container(
        width: double.infinity, //This will expand the width of the container to the whole page
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),


        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //This will shift everything to the left
            children: <Widget>[
              MyDayHeader(),
              //Show tasks need to do still 
              Expanded(
                child: Consumer<TaskProvider>(
                  builder: (context, provider, child){
                    return StreamBuilder(
                      stream: getTasks(),
                      builder: (context, snapshot){
                      if(snapshot.data == null){
                        return Container(
                          child: SpinKitFoldingCube(
                          itemBuilder: (BuildContext context, int index) {
                            return DecoratedBox(
                            decoration: BoxDecoration(
                            color: Colors.red[900]
                              ),
                            );
                          },
                        )
                      );
                    }
                    return ListView.builder(
                      itemCount: provider.tasks.length,
                      itemBuilder: (BuildContext context, int index){
                        return Dismissible(
                          background: Container(decoration: BoxDecoration(color: Colors.red[900], borderRadius: BorderRadius.circular(20.0))),
                          resizeDuration: Duration(seconds: 1),
                          direction: DismissDirection.endToStart,
                          key: ValueKey(provider.tasks[index]),
                          child: TaskCardWidget(provider.tasks[index]),
                          onDismissed: (direction) {
                          // Remove the item from the data source.
                          setState(() async {
                            await provider.removeTask(provider.tasks[index]);
                          });
                        });
                      },
                    );
                  }
                );
                  }
                )
              ),
              //Show all completed tasks 
              Container(alignment: Alignment.bottomLeft, child:AddTask()),
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
              title: Text('My Day'),
              onTap: () {
                // Update the state of the app.
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Upcoming'),
              onTap: () {
                // Update the state of the app.
                Navigator.pushNamed(context, '/calendar');
              },
            ),
          ],
        ),
      ),
    );
  }
}

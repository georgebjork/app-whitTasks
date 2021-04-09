import 'package:app_whittasks/Classes/TaskProvider.dart';
import 'package:app_whittasks/Widgets/AddTask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Widgets/TaskCardWidget.dart';
import 'Widgets/MyDayHeader.dart';
import 'Classes/Task.dart';
import 'Classes/httpService.dart';

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
                    return FutureBuilder(
                      future: provider.service.getTask(), 
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                      //This will display a loading animation while it pulls tasks
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
                    //If the snapshot does have data we want to populate this in a local list for easier manipulation
                    if(snapshot.data != null){
                      //Clear the list expecting there to be new items
                      provider.tasks.clear();
                      //Populate list
                      for(int i = 0; i < snapshot.data.length; i++){
                        provider.tasks.add(snapshot.data[i]);
                      }
                    }
                      
                    return ListView.builder(
                      itemCount: provider.tasks.length,
                      itemBuilder: (BuildContext context, int index){
                        return Dismissible(
                          background: Container(decoration: BoxDecoration(color: Colors.red[900], borderRadius: BorderRadius.circular(20.0))),
                          resizeDuration: Duration(seconds: 1),
                          direction: DismissDirection.endToStart,
                          key: ValueKey(provider.tasks[index]),
                          child: TaskCardWidget(provider.tasks[index])
                        );
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
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}

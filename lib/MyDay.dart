import 'package:app_whittasks/Classes/TaskProvider.dart';
import 'package:app_whittasks/Classes/ThemeProvider.dart';
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
  bool _value = false;
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
        // column holds all the widgets in the drawer
        child: Column(
          children: <Widget>[
            Expanded(
              // ListView contains a group of widgets that scroll inside the drawer
              child: ListView(
                children: <Widget>[
                  DrawerHeader(child: Text(''), decoration: BoxDecoration(color: Theme.of(context).accentColor,),),
                  ListTile(
                    title: Text('My Day'),
                    leading: Icon(Icons.wb_sunny),
                    onTap: () {
                    // Update the state of the app.
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Calendar'),
                    leading: Icon(Icons.calendar_today_rounded),
                    onTap: () {
                    // Update the state of the app.
                      Navigator.pushNamed(context, '/calendar');
                    },
                  ),
                ],
              ),
            ),
            // This container holds the align
            Container(
            // This align moves the children to the bottom
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                // This container holds all the children that will be aligned
                // on the bottom and should not scroll with the above ListView
                child: Container(
                    child: Column(
                      children: <Widget>[
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings')
                        ),
                        SwitchListTile(
                          title: Text('Light or Dark Mode'),
                          secondary: _value ? Icon(Icons.brightness_2_outlined) : Icon(Icons.brightness_low_sharp),
                          value: _value, 
                          activeColor: Theme.of(context).accentColor,
                          onChanged: (toggled) {
                            setState(() {
                                _value = toggled;
                                if(_value == true){
                                  context.read<ThemeProvider>().setTheme("dark");
                                }else{
                                  context.read<ThemeProvider>().setTheme("light");
                                }
                              }
                            );
                          }
                        )
                      ],
                    )
              )
              )
            )
          ],
        ),
      )
    );
  }
}

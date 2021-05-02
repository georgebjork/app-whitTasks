import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Classes/Task.dart';
import 'CheckMarkBox.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../EditTask.dart';
class TaskCardWidget extends StatefulWidget {
  Task task;
  TaskCardWidget(this.task);

  @override
  TaskCardWidgetState createState() => TaskCardWidgetState(task);
}

class TaskCardWidgetState extends State<TaskCardWidget> {

  Task task; 
  TaskCardWidgetState(this.task);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditTask(task),),);
      },
      child: Container(
        width: double.infinity, //this makes it take up the whole space in the container
        padding: EdgeInsets.symmetric(
            //padding of text in container
            vertical: 17.0,
            horizontal: 20.0
          ),
        margin: EdgeInsets.only(
          bottom: 10.0    //Change the distance between two containers 
        ),
        decoration: BoxDecoration(
          //Change the color and the rounded edges and add 50% opacity 
          //Theme.of(context).accentColor
          color: Theme.of(context).cardColor, //.withOpacity(0.6), 
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Row( 
          children: [ 
          CheckMarkBox(task), 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ 
              Text(task.getTask(), style: TextStyle(color: Colors.grey[300], fontSize: 15, fontWeight: FontWeight.bold, decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none )),
              Row(
                children: <Widget>[
                  Icon(Icons.calendar_today_sharp, color: Colors.white, size: 14 ),
                  SizedBox(width: 5),
                  Text(task.getFormattedDate(), style: TextStyle(color: Colors.grey[350], fontSize: 15,))
                ],
              )
            ],
          ),]
          ),
      ),
    );
  }
}

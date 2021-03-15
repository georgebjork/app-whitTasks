import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../Classes/Task.dart';
import 'package:provider/provider.dart';
import '../Classes/TaskProvider.dart';

class CheckMarkBox extends StatefulWidget {

  Task task;
  CheckMarkBox(this.task);

  CheckMarkBoxState createState() => CheckMarkBoxState(task);
}

class CheckMarkBoxState extends State<CheckMarkBox> {
  bool _isChecked = false;
  
  Task task;
  CheckMarkBoxState(this.task);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _isChecked = !_isChecked;   //Sets the state of the widget 
          task.isDone = _isChecked;
          //context.read<TaskProvider>().removeTask(task);

        });
      },  
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),

        child: AnimatedContainer( //An animated contatiner makes to color change with an animation 
          duration: Duration(milliseconds: 1000), //how long the animation is 
          curve: Curves.fastLinearToSlowEaseIn, 
          decoration: BoxDecoration(
            borderRadius : BorderRadius.circular(30.0),   //Makes the box a circle 
            border: _isChecked ? null : Border.all(color: Colors.grey, width: 2.0), //If the it is not selected then we will have a see through circle with a grey border
            color: _isChecked ? Colors.red[900] : Colors.transparent), //If it is selected then it will be red
          width: 20,
          height: 20,
          child: _isChecked ? Icon( //Sets an icon to the check box 
            Icons.check,
            color: Colors.white,
            size: 15
          ) : null,
        ),
      ),
    );
  }
}

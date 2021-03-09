import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CheckMarkBox extends StatefulWidget {
  CheckMarkBoxState createState() => CheckMarkBoxState();
}

class CheckMarkBoxState extends State<CheckMarkBox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _isChecked = !_isChecked;   //Sets the state of the widget 
        });
      },  
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),

        child: AnimatedContainer( //An animated contatiner makes to color change with an animation 
          duration: Duration(milliseconds: 1000), //how long the animation is 
          curve: Curves.fastLinearToSlowEaseIn, 
          decoration: BoxDecoration(
            borderRadius : BorderRadius.circular(30.0),   //Makes the box a circle 
            border: _isChecked ? null : Border.all(color: Colors.grey, width: 2.0), //If the it is not selected then we will have a see through circle with a grey border
            color: _isChecked ? Colors.red[900] : Colors.transparent), //If it is selected then it will be red
          width: 25,
          height: 25,
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

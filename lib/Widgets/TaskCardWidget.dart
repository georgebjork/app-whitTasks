import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, //this makes it take up the whole space in the container
      padding: EdgeInsets.symmetric(
          //padding of text in container
          vertical: 32.0,
          horizontal: 24.0),

      margin: EdgeInsets.only(
        bottom: 10.0
      ),
      decoration: BoxDecoration(
        //Chang the color and the rounded edges 
        color: Colors.grey[600], 
        borderRadius: BorderRadius.circular(20.0)),

      child: Text("Hello There"),
    );
  }
}

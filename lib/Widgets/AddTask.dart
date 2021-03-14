import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Classes/Task.dart';


class AddTask extends StatelessWidget {
  String taskText = "Hello World";
  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity, //this makes it take up the whole space in the container
          padding: EdgeInsets.symmetric(
          //padding of text in container
            vertical: 30.0,
            horizontal: 24.0),

      margin: EdgeInsets.only(
        top: 20.0,
        //bottom: 10.0    //Change the distance between two containers 
      ),
      decoration: BoxDecoration(
        //Change the color and the rounded edges and add 50% opacity 
        color: Colors.red[800].withOpacity(0.5), 
        borderRadius: BorderRadius.circular(20.0)),
    );
  }
}
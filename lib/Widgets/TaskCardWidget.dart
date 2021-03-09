import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CheckMarkBox.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        bottom: 10.0    //Change the distance between two containers 
      ),
      decoration: BoxDecoration(
        //Change the color and the rounded edges and add 50% opacity 
        color: Colors.grey[600].withOpacity(0.5), 
        borderRadius: BorderRadius.circular(20.0)),

      child: Row( 
        children: [CheckMarkBox(), Text("This is an example task", style: TextStyle(color: Colors.white,)),]
        ),
    );
  }
}

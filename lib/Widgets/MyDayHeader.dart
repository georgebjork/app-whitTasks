import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
    

class MyDayHeader extends StatelessWidget {

  String getDate()
  {
      var dt = DateTime.now();
      var newFormat = DateFormat.yMMMMd('en_US');
      String updatedDt = newFormat.format(dt);

      return updatedDt;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0, top: 5.0),
      width: double.infinity,
      child: Column( 
        children:[ Text("My Day", style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),  Text(getDate(), style: TextStyle(color: Colors.white, fontSize: 15.0)),],
        crossAxisAlignment: CrossAxisAlignment.start)
    );
  }
}
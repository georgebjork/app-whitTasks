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
      margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
      width: double.infinity,
      child: Column( children:[Center(child: Text("My Day")), Center(child: Text(getDate()),)])
    );
  }
}
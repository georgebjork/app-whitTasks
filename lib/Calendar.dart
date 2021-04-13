import 'package:app_whittasks/Classes/TaskProvider.dart';
import 'package:app_whittasks/Widgets/AddTask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:table_calendar/table_calendar.dart';

import 'Widgets/TaskCardWidget.dart';
import 'Widgets/MyDayHeader.dart';
import 'Classes/Task.dart';
import 'Classes/httpService.dart';

class Calendar extends StatefulWidget {
  
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(elevation: 0.0,),
        body: Container(
          width: double.infinity, //This will expand the width of the container to the whole page
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
          color: Colors.grey[900],
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            calendarStyle: CalendarStyle(
              todayDecoration:  BoxDecoration(borderRadius : BorderRadius.circular(30.0), color: Colors.red[900])
            ),
          )
        )
      );
    }
}
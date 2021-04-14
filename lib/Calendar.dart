import 'package:app_whittasks/Classes/TaskProvider.dart';
import 'package:app_whittasks/Widgets/AddTask.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
    
  bool checkDate(Task t){
    var formatter = new DateFormat('yyyy-MM-dd');
     String nowString;
    if(_selectedDay == null){
      nowString = formatter.format(_focusedDay);
    }else{
      nowString = formatter.format(_selectedDay);
    }
    

    var due_date = DateTime.parse(t.date);
    String dateString = formatter.format(due_date);
    
    if(dateString == nowString){
      return true;
    }
    return false;
  }

  void initState(){

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(elevation: 0.0,),
      body: Container(
        width: double.infinity, //This will expand the width of the container to the whole page
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
        color: Colors.grey[900],
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green[900]),
                todayDecoration:  BoxDecoration(shape: BoxShape.circle, color: Colors.red[900]),
                defaultTextStyle: TextStyle(color: Colors.white),
                weekendTextStyle: TextStyle(color: Colors.white)
              ),
              daysOfWeekStyle: DaysOfWeekStyle( 
                weekdayStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                weekendStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
              ),
                headerStyle: HeaderStyle( 
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white,),
                rightChevronIcon: Icon(Icons.chevron_right_outlined, color: Colors.white,),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<TaskProvider>(
                  builder: (context, provider, child){
                    return ListView.builder(
                    itemCount: provider.tasks.length,
                    itemBuilder: (BuildContext context, int index){
                      return Dismissible(
                        background: Container(decoration: BoxDecoration(color: Colors.red[900], borderRadius: BorderRadius.circular(20.0))),
                        resizeDuration: Duration(seconds: 1),
                        direction: DismissDirection.endToStart,
                        key: ValueKey(provider.tasks[index]),
                        child: checkDate(provider.tasks[index]) ? TaskCardWidget(provider.tasks[index]) : null,
                        onDismissed: (direction) {
                        // Remove the item from the data source.
                        setState(() async {
                          await provider.removeTask(provider.tasks[index]);
                        });
                      });
                    },
                  );
                  }
              )
            )
          ],
        )
      )
    );
  }
}
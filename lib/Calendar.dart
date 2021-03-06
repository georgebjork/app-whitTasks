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
  //Default format
  CalendarFormat _calendarFormat = CalendarFormat.month;
  //Current day is today
  DateTime _focusedDay = DateTime.now();
  //Day user selected
  DateTime _selectedDay;
    
  bool checkDate(Task t){
    //create a new date formatter
    var formatter = new DateFormat('yyyy-MM-dd');
    String nowString;
    //These will determine what the selected day is
    if(_selectedDay == null){
      nowString = formatter.format(_focusedDay);
    }else{
      nowString = formatter.format(_selectedDay);
    }
    
    //Parse into a new date format
    var due_date = DateTime.parse(t.date);
    //date string is going to be a formatted due_date
    String dateString = formatter.format(due_date);
    
    //If they are the same return true
    if(dateString == nowString){
      return true;
    }
    //Not the same day
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
              child: TableCalendar(
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
                  selectedDecoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).accentColor),
                  todayDecoration:  BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).accentColor),
                  defaultTextStyle: Theme.of(context).textTheme.bodyText1,
                  weekendTextStyle: TextStyle()
                ),
                daysOfWeekStyle: DaysOfWeekStyle( 
                  weekdayStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  weekendStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                ),
                headerStyle: HeaderStyle( 
                  formatButtonDecoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.all(Radius.circular(25))),
                  formatButtonVisible: true,
                  formatButtonShowsNext: false,
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  titleCentered: false,
                  titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  leftChevronIcon: Icon(Icons.chevron_left,),
                  rightChevronIcon: Icon(Icons.chevron_right_outlined,),
                ),
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.only(topRight: Radius.circular(36), topLeft: Radius.circular(36)), 
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0, top: 20.0),
                  child: Consumer<TaskProvider>(
                      builder: (context, provider, child){
                        return ListView.builder(
                        itemCount: provider.tasks.length,
                        itemBuilder: (BuildContext context, int index){
                          return Dismissible(
                            background: Container(decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(20.0))),
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
                  ),
                )
              ),
            )
          ],
        )
      )
    );
  }
}
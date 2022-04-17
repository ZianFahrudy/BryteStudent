import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  @override
  Widget build(BuildContext context) {
    final selectedDay = DateTime.now();
    var format = CalendarFormat.month;

    return TableCalendar(
      focusedDay: selectedDay,
      firstDay: DateTime.utc(2021, 12, 12),
      lastDay: DateTime.utc(2023, 12, 12),
      calendarFormat: format,
      onFormatChanged: (s) {
        setState(() {
          format = s;
        });
      },
      startingDayOfWeek: StartingDayOfWeek.sunday,
      daysOfWeekVisible: true,
      // onDaySelected: ,
    );
  }
}

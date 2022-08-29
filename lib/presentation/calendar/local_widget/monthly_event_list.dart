import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/data/model/calendar/response/event_model.dart';
import 'assign_class_card.dart';
import 'course_class_card.dart';

class MonthlyEventList extends StatelessWidget {
  const MonthlyEventList({
    Key? key,
    required ValueNotifier<List<Event>> selectedEvents,
  })  : _selectedEvents = selectedEvents,
        super(key: key);

  final ValueNotifier<List<Event>> _selectedEvents;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Event>>(
      valueListenable: _selectedEvents,
      builder: (context, value, _) {
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: value.length,
          itemBuilder: (context, i) {
            if ((value[i].type == 'class')) {
              final date =
                  DateFormat('dd MMM').format(DateTime.parse(value[i].date!));

              final startTime = DateFormat('HH:mm')
                  .format(DateTime.parse(value[i].startTime!));

              final endTime =
                  DateFormat('HH:mm').format(DateTime.parse(value[i].endTime!));

              return CourseClassCard(
                  attdStatus: value[i].attdStatus ?? '',
                  event: value[i],
                  date: date,
                  startTime: startTime,
                  endTime: endTime);
            } else {
              return AssignClassCard(
                value: value[i],
              );
            }
          },
        );
      },
    );
  }
}

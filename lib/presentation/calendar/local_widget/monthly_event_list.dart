import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/data/model/calendar/response/event_model.dart';
import 'assign_class_card.dart';
import 'course_class_card.dart';

class MonthlyEventList extends StatefulWidget {
  const MonthlyEventList({
    Key? key,
    required ValueNotifier<List<Event>> selectedEvents,
  })  : _selectedEvents = selectedEvents,
        super(key: key);

  final ValueNotifier<List<Event>> _selectedEvents;

  @override
  State<MonthlyEventList> createState() => _MonthlyEventListState();
}

class _MonthlyEventListState extends State<MonthlyEventList> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Event>>(
      valueListenable: widget._selectedEvents,
      builder: (context, value, _) {
        return Expanded(
          child: ListView.builder(
            // shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: value.length,
            itemBuilder: (context, i) {
              if ((value[i].type == 'class')) {
                final date =
                    DateFormat('dd MMM').format(DateTime.parse(value[i].date!));

                final startTime = DateFormat('HH:mm')
                    .format(DateTime.parse(value[i].startTime!));

                final endTime = DateFormat('HH:mm')
                    .format(DateTime.parse(value[i].endTime!));

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
          ),
        );
      },
    );
  }
}

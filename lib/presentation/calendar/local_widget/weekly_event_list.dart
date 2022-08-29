import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/utils/typography.dart';
import '../../../core/data/model/calendar/response/event_model.dart';
import 'assign_class_card.dart';
import 'course_class_card.dart';
import 'empty_event_card.dart';

class WeeklyEventList extends StatelessWidget {
  const WeeklyEventList({
    Key? key,
    required this.eventPerweek,
  }) : super(key: key);

  final List<DataCalendarEvent> eventPerweek;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: eventPerweek
          .map(
            (e) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text(
                    DateFormat('EEEE, dd MMMM yyyy')
                        .format(DateTime.parse(e.date)),
                    style: BryteTypography.headerSemiBold,
                  ),
                ),
                if (e.events.isEmpty) const EmptyEventCard(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: List.generate(
                      e.events.length,
                      (index) {
                        if (e.events[index].type == 'class') {
                          final date = DateFormat('dd MMM')
                              .format(DateTime.parse(e.events[index].date!));

                          final startTime = DateFormat('HH:mm').format(
                              DateTime.parse(e.events[index].startTime!));

                          final endTime = DateFormat('HH:mm')
                              .format(DateTime.parse(e.events[index].endTime!));
                          return CourseClassCard(
                              attdStatus: e.events[index].attdStatus ?? '',
                              event: e.events[index],
                              date: date,
                              startTime: startTime,
                              endTime: endTime);
                        } else {
                          return AssignClassCard(
                            value: e.events[index],
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          )
          .toList(),
    );
  }
}

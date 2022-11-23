import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../components/utils/typography.dart';
import '../../../core/data/model/calendar/response/event_model.dart';
import 'assign_class_card.dart';
import 'course_class_card.dart';
import 'empty_event_card.dart';

class WeeklyEventList extends StatefulWidget {
  const WeeklyEventList({
    Key? key,
    required this.eventPerweek,
    required this.itemScrollController,
    required this.itemPositionsListener,
  }) : super(key: key);

  final List<DataCalendarEvent> eventPerweek;
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;

  @override
  State<WeeklyEventList> createState() => _WeeklyEventListState();
}

class _WeeklyEventListState extends State<WeeklyEventList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollablePositionedList.builder(
        itemScrollController: widget.itemScrollController,
        itemPositionsListener: widget.itemPositionsListener,
        itemCount: widget.eventPerweek.length,
        itemBuilder: (context, i) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                DateFormat('EEEE, dd MMMM yyyy')
                    .format(DateTime.parse(widget.eventPerweek[i].date)),
                style: BryteTypography.headerSemiBold,
              ),
            ),
            if (widget.eventPerweek[i].events.isEmpty) const EmptyEventCard(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: List.generate(
                  widget.eventPerweek[i].events.length,
                  (index) {
                    if (widget.eventPerweek[i].events[index].type == 'class') {
                      final date = DateFormat('dd MMM').format(DateTime.parse(
                          widget.eventPerweek[i].events[index].date!));

                      final startTime = DateFormat('HH:mm').format(
                          DateTime.parse(
                              widget.eventPerweek[i].events[index].startTime!));

                      final endTime = DateFormat('HH:mm').format(DateTime.parse(
                          widget.eventPerweek[i].events[index].endTime!));
                      return CourseClassCard(
                        attdStatus:
                            widget.eventPerweek[i].events[index].attdStatus ??
                                '',
                        event: widget.eventPerweek[i].events[index],
                        date: date,
                        startTime: startTime,
                        endTime: endTime,
                      );
                    } else {
                      return AssignClassCard(
                        value: widget.eventPerweek[i].events[index],
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:developer';

import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/calendar/event_bloc.dart';
import 'package:bryte/core/data/model/calendar/request/event_body.dart';
import 'package:bryte/core/data/model/calendar/response/event_model.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../components/utils/palette.dart';
import 'package:bryte/components/extension/datetime_extension.dart';

enum TabCalendarType { weekly, monthly }

class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final _calendarFormatWeek = CalendarFormat.week;
  CalendarFormat _calendarFormatMonth = CalendarFormat.month;

  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  DateTime? lastDay;
  DateTime? firstDay;

  List<List<DateTime>>? week;

  // final last = DateTime(_selectedDay.year, _focusedDay.month + 1, 0);

  // DateTime first = DateTime(_focusedDay.year, _focusedDay.month, 1);

  List<List<DateTime>> getWeeksForRange(DateTime start, DateTime end) {
    var result = <List<DateTime>>[];

    var date = start;
    var week = <DateTime>[];

    while (date.difference(end).inDays <= 0) {
      // start new week on Monday
      if (date.weekday == 1 && week.isNotEmpty) {
        result.add(week);
        week = <DateTime>[];
      }

      week.add(date);

      date = date.add(const Duration(days: 1));
    }

    result.add(week);

    return result;
  }

  List<DateTime> dayOfWeeks = [];
  @override
  void initState() {
    super.initState();
    lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);

    week = getWeeksForRange(firstDay!, lastDay!);

    _selectedDay = _focusedDay;
    setState(() {
      _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    });
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    eventBloc.close();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  final kEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  void setCalendarSchedule(DataCalendarEvent calendars) {
    final mapFetch = <DateTime, List<Event>>{};

    final createTimes = DateTime.parse(calendars.date);
    final listEvent = calendars.events;
    // final originals = mapFetch[createTimes];

    mapFetch[createTimes] = listEvent;

    kEvents.addAll(mapFetch);
  }

  final eventBloc = getIt<EventBloc>();
  final box = GetStorage();
  final selectedValue = ValueNotifier<TabCalendarType>(TabCalendarType.weekly);

  DateTime lastDayOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  DateTime firstDayOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  List<DataCalendarEvent> eventPerweek = [];

  @override
  Widget build(BuildContext context) {
    String token = box.read(KeyConstant.token);
    String userId = box.read(KeyConstant.userId);

    return BlocProvider(
      create: (context) => eventBloc
        ..add(
          GetCalendarEvent(
            EventBody(
              token: token,
              userid: userId,
              startDate: DateFormat('yyyy-MM-dd').format(firstDayOfMonth),
              endDate: DateFormat('yyyy-MM-dd').format(lastDayOfMonth),
            ),
          ),
        )
        ..add(GetCalendarEventPerWeek(
            body: EventBody(
          token: token,
          userid: userId,
          startDate:
              DateFormat('yyyy-MM-dd').format(_focusedDay.weekOfMonth == 1
                  ? week![0].first
                  : _focusedDay.weekOfMonth == 2
                      ? week![1].first
                      : _focusedDay.weekOfMonth == 3
                          ? week![2].first
                          : _focusedDay.weekOfMonth == 4
                              ? week![3].first
                              : week![4].first),
          endDate: DateFormat('yyyy-MM-dd').format(_focusedDay.weekOfMonth == 1
              ? week![0].last
              : _focusedDay.weekOfMonth == 2
                  ? week![1].last
                  : _focusedDay.weekOfMonth == 3
                      ? week![2].last
                      : _focusedDay.weekOfMonth == 4
                          ? week![3].last
                          : week![4].last),
        ))),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ))
          ],
          title: Image.asset(AssetConstant.bryteLogoWhite),
        ),
        body: BlocConsumer<EventBloc, EventState>(
          listener: (context, state) {
            if (state is EventSuccess) {
              log('KALENDARLIST :${state.response.data.last.date}');
              for (var i = 0; i < state.response.data.length; i++) {
                setCalendarSchedule(state.response.data[i]);
              }
            } else if (state is EventPerWeekSuccess) {
              log('EVENT PER WEEK SUCCESS');
              eventPerweek = state.response.data;
              log('WEEKKU ${eventPerweek[0].date}');
            }
          },
          builder: (context, state) {
            _selectedEvents.value = _getEventsForDay(_selectedDay!);

            return ValueListenableBuilder(
              valueListenable: selectedValue,
              builder: (context, _, __) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedCalendar(selectedValue: selectedValue),
                    TableCalendar<Event>(
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (BuildContext context, date, events) {
                          if (events.isEmpty) return const SizedBox();
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: events.length > 1 ? 2 : 1,
                              itemBuilder: (context, index) {
                                return events[index].type == 'class'
                                    ? const Padding(
                                        padding: EdgeInsets.only(top: 30),
                                        child: Icon(
                                          Icons.school,
                                          color: Palette.purple,
                                          size: 15,
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.only(top: 30),
                                        child: Icon(
                                          Icons.assignment,
                                          size: 15,
                                          color: Palette.darkPurple,
                                        ),
                                      );
                              });
                        },
                      ),
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      calendarFormat:
                          selectedValue.value == TabCalendarType.weekly
                              ? _calendarFormatWeek
                              : _calendarFormatMonth,
                      rangeSelectionMode: _rangeSelectionMode,
                      eventLoader: _getEventsForDay,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      enabledDayPredicate: (s) {
                        return true;
                      },
                      onRangeSelected: (start, end, focusday) {
                        _focusedDay = focusday;
                        _rangeStart = start;
                        _rangeEnd = end;
                        log('$start');
                        log('$end');
                        log('$focusday');
                      },
                      onDaySelected: _onDaySelected,
                      onFormatChanged: (format) {
                        if (_calendarFormatMonth != format) {
                          setState(() {
                            _calendarFormatMonth = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        log('${focusedDay.weekOfMonth}');
                        _focusedDay = focusedDay;

                        final last = DateTime(
                            _focusedDay.year, _focusedDay.month + 1, 0);

                        DateTime first =
                            DateTime(_focusedDay.year, _focusedDay.month, 1);

                        eventBloc.add(GetCalendarEvent(EventBody(
                            token: token,
                            userid: userId,
                            startDate: DateFormat('yyyy-MM-dd').format(first),
                            endDate: DateFormat('yyyy-MM-dd').format(last))));

                        week = getWeeksForRange(first, last);

                        eventBloc.add(GetCalendarEventPerWeek(
                            body: EventBody(
                          token: token,
                          userid: userId,
                          startDate: DateFormat('yyyy-MM-dd')
                              .format(_focusedDay.weekOfMonth == 1
                                  ? week![0].first
                                  : _focusedDay.weekOfMonth == 2
                                      ? week![1].first
                                      : _focusedDay.weekOfMonth == 3
                                          ? week![2].first
                                          : _focusedDay.weekOfMonth == 4
                                              ? week![3].first
                                              : week![4].first),
                          endDate: DateFormat('yyyy-MM-dd')
                              .format(_focusedDay.weekOfMonth == 1
                                  ? week![0].last
                                  : _focusedDay.weekOfMonth == 2
                                      ? week![1].last
                                      : _focusedDay.weekOfMonth == 3
                                          ? week![2].last
                                          : _focusedDay.weekOfMonth == 4
                                              ? week![3].last
                                              : week![4].last),
                        )));

                        log('rangeWeek $week');
                        // log('${_focusedDay.day}');
                      },
                      headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          leftChevronPadding: const EdgeInsets.only(left: 0),
                          rightChevronPadding: const EdgeInsets.only(right: 0),
                          headerPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          titleCentered: true,
                          decoration:
                              const BoxDecoration(color: Palette.primary100),
                          titleTextStyle: BryteTypography.headerExtraBold
                              .copyWith(color: Palette.headerSpecial)),
                    ),
                    const SizedBox(height: 8.0),
                    if (_selectedEvents.value.isEmpty &&
                        selectedValue.value == TabCalendarType.monthly)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          DateFormat('EEEE, dd MMMM yyyy')
                              .format(_selectedDay!),
                          style: BryteTypography.headerSemiBold,
                        ),
                      ),
                    if (_selectedEvents.value.isEmpty &&
                        selectedValue.value == TabCalendarType.monthly)
                      Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                            color: Palette.primary100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            Image.asset(AssetConstant.emptyZzz),
                            const SizedBox(width: 16),
                            Text(
                              'No classes, no assignments, nothing!',
                              style: BryteTypography.bodyMedium.copyWith(
                                  color: Palette.headerSpecial,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    if (selectedValue.value == TabCalendarType.weekly)
                      (eventPerweek.every((element) => element.events.isEmpty))
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(AssetConstant.emptyCalendar),
                                  const SizedBox(
                                    height: 17,
                                  ),
                                  Text(
                                    'Apparently you are free..',
                                    style: BryteTypography.headerExtraBold
                                        .copyWith(color: Palette.darkPurple),
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    'Enjoy your free time, while it lasts ;)',
                                    style: BryteTypography.titleMedium,
                                  )
                                ],
                              ),
                            )
                          : Column(
                              children: eventPerweek
                                  .map((e) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 10),
                                            child: Text(
                                              DateFormat('EEEE, dd MMMM yyyy')
                                                  .format(
                                                      DateTime.parse(e.date)),
                                              style: BryteTypography
                                                  .headerSemiBold,
                                            ),
                                          ),
                                          if (e.events.isEmpty)
                                            const EmptyEventCard(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              children: List.generate(
                                                e.events.length,
                                                (index) {
                                                  if (e.events[index].type ==
                                                      'class') {
                                                    final date = DateFormat(
                                                            'dd MMM')
                                                        .format(DateTime.parse(e
                                                            .events[index]
                                                            .date!));

                                                    final startTime = DateFormat(
                                                            'HH:mm')
                                                        .format(DateTime.parse(e
                                                            .events[index]
                                                            .startTime!));

                                                    final endTime = DateFormat(
                                                            'HH:mm')
                                                        .format(DateTime.parse(e
                                                            .events[index]
                                                            .endTime!));
                                                    return CourseClassCard(
                                                        attdStatus: e
                                                                .events[index]
                                                                .attdStatus ??
                                                            '',
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
                                      ))
                                  .toList(),
                            ),
                    if (selectedValue.value == TabCalendarType.monthly)
                      ValueListenableBuilder<List<Event>>(
                        valueListenable: _selectedEvents,
                        builder: (context, value, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            itemCount: value.length,
                            itemBuilder: (context, i) {
                              if ((value[i].type == 'class')) {
                                final date = DateFormat('dd MMM')
                                    .format(DateTime.parse(value[i].date!));

                                final startTime = DateFormat('HH:mm').format(
                                    DateTime.parse(value[i].startTime!));

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
                          );
                        },
                      ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class EmptyEventCard extends StatelessWidget {
  const EmptyEventCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
          color: Palette.primary100, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Image.asset(AssetConstant.emptyZzz),
          const SizedBox(width: 16),
          Text(
            'No classes, no assignments, nothing!',
            style: BryteTypography.bodyMedium.copyWith(
                color: Palette.headerSpecial,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          )
        ],
      ),
    );
  }
}

class AssignClassCard extends StatelessWidget {
  const AssignClassCard({
    Key? key,
    required this.value,
  }) : super(key: key);

  final Event value;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Palette.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  DateFormat('dd MMM')
                      .format(DateTime.parse(value.assignDeadline!)),
                  style: brytStyleJudul.copyWith(
                    fontSize: 14,
                    color: Palette.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  DateFormat('HH:mm')
                      .format(DateTime.parse(value.assignDeadline!)),
                  style: brytStyleJudul.copyWith(
                    fontSize: 16,
                    color: Palette.purple,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Container(
              width: 2,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              color: Palette.secondary,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.assignment,
                      size: 15,
                      color: Palette.neutral300,
                    ),
                    const SizedBox(width: 5),
                    Text(ReCase(value.type).constantCase,
                        style: BryteTypography.bodyRegular.copyWith(
                          color: Palette.neutral300,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: Get.width - 260,
                  child: Text(
                    value.assignName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: BryteTypography.headerExtraBold.copyWith(
                        fontSize: 16, color: Colors.black.withOpacity(.6)),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      height: 11,
                      width: 11,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Palette.sunkist400),
                    ),
                    SizedBox(
                      width: Get.width - 300,
                      child: Text(
                        value.assignDescp!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: brytStyleJudul.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Palette.lightGrey),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                value.assignAttempt! ? 'SUBMITTED' : 'NOT ATTEMPTED',
                style: BryteTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        value.assignAttempt! ? Palette.sprite500 : Palette.red),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:
                    value.assignAttempt! ? Palette.sprite200 : Palette.coke200,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CourseClassCard extends StatelessWidget {
  const CourseClassCard({
    Key? key,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.event,
    required this.attdStatus,
  }) : super(key: key);

  final String date;
  final String startTime;
  final String endTime;
  final Event event;
  final String attdStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Palette.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.school,
                              size: 15,
                              color: Palette.neutral300,
                            ),
                            const SizedBox(width: 5),
                            Text(ReCase(event.type).constantCase,
                                style: BryteTypography.bodyRegular.copyWith(
                                  color: Palette.neutral300,
                                )),
                          ],
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                            width: Get.width - 210,
                            child: Text(
                              event.classes!,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: BryteTypography.headerExtraBold.copyWith(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(.6)),
                            )),
                        const SizedBox(height: 4),
                        Text(
                          '$date • $startTime - $endTime',
                          style: BryteTypography.bodyMedium
                              .copyWith(color: Palette.purple),
                        )
                      ],
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
                const Spacer(),
                if (!(attdStatus == 'W'))
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                        color: Palette.sprite200,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      attdStatus == 'P'
                          ? 'PRESENT'
                          : attdStatus == 'L'
                              ? 'LATE'
                              : attdStatus == 'A'
                                  ? 'ABSENT'
                                  : 'EXCUSED',
                      style: BryteTypography.button
                          .copyWith(color: Palette.sprite500),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SegmentedCalendar extends StatelessWidget {
  const SegmentedCalendar({
    Key? key,
    required this.selectedValue,
  }) : super(key: key);

  final ValueNotifier<TabCalendarType> selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Palette.primary100,
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: CustomSlidingSegmentedControl<TabCalendarType>(
              height: 30,
              innerPadding: const EdgeInsets.all(0),
              children: {
                TabCalendarType.weekly: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Weekly',
                    style: brytStylebtn.copyWith(
                        color: selectedValue.value == TabCalendarType.monthly
                            ? Palette.headerSpecial
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                TabCalendarType.monthly: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Monthly',
                    style: brytStylebtn.copyWith(
                        color: selectedValue.value == TabCalendarType.weekly
                            ? Palette.darkPurple
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              },
              decoration: BoxDecoration(
                color: Palette.secondary100,
                borderRadius: BorderRadius.circular(27),
              ),
              thumbDecoration: BoxDecoration(
                color: Palette.headerSpecial,
                borderRadius: BorderRadius.circular(27),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(
                      0.0,
                      2.0,
                    ),
                  ),
                ],
              ),
              onValueChanged: (TabCalendarType value) {
                selectedValue.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

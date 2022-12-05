import 'dart:collection';
import 'dart:developer';

import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/calendar/event_bloc.dart';
import 'package:bryte/core/data/model/calendar/request/event_body.dart';
import 'package:bryte/core/data/model/calendar/response/event_model.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../components/utils/palette.dart';
import 'package:bryte/components/extension/datetime_extension.dart';

import '../local_widget/event_date_label.dart';
import '../local_widget/every_empty_event.dart';
import '../local_widget/monthly_event_list.dart';
import '../local_widget/no_event_card_calendar.dart';
import '../local_widget/segmented_calendar.dart';
import '../local_widget/weekly_event_list.dart';

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

      if (selectedValue.value == TabCalendarType.weekly) {
        for (var i = 0; i < eventPerweek.length; i++) {
          log(eventPerweek[3].date);

          if (DateFormat('yyyy-MM-dd').format(_selectedDay!) ==
              eventPerweek[i].date) {
            itemScrollController.scrollTo(
                index: i, duration: const Duration(milliseconds: 250));
          }
        }
      }
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

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

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
          title: Image.asset(
            AssetConstant.bryteLogoWhite,
            width: 59,
          ),
        ),
        body: BlocConsumer<EventBloc, EventState>(
          listener: (context, state) {
            if (state is EventSuccess) {
              log('Get Event Success');
              for (var i = 0; i < state.response.data.length; i++) {
                setCalendarSchedule(state.response.data[i]);
              }
            } else if (state is EventPerWeekSuccess) {
              log('Get Event per week Success');
              eventPerweek = state.response.data;
            }
          },
          builder: (context, state) {
            _selectedEvents.value = _getEventsForDay(_selectedDay!);
            return ValueListenableBuilder(
              valueListenable: selectedValue,
              builder: (context, _, __) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SegmentedCalendar(selectedValue: selectedValue),
                  TableCalendar<Event>(
                    calendarBuilders: _calendarBuilders(),
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
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
                    },
                    onDaySelected: _onDaySelected,
                    onFormatChanged: (format) {
                      if (_calendarFormatMonth != format) {
                        setState(() {
                          _calendarFormatMonth = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) =>
                        _onPageChanged(focusedDay, token, userId),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      leftChevronIcon: const Icon(
                        Icons.chevron_left,
                        color: Palette.purple,
                      ),
                      rightChevronIcon: const Icon(
                        Icons.chevron_right,
                        color: Palette.purple,
                      ),
                      leftChevronPadding: const EdgeInsets.only(left: 0),
                      rightChevronPadding: const EdgeInsets.only(right: 0),
                      headerPadding: const EdgeInsets.symmetric(vertical: 10),
                      titleCentered: true,
                      decoration:
                          const BoxDecoration(color: Palette.primary100),
                      titleTextStyle: BryteTypography.headerExtraBold.copyWith(
                        color: Palette.headerSpecial,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      cellPadding: const EdgeInsets.symmetric(),
                      todayTextStyle: BryteTypography.bodyRegular.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      todayDecoration: const BoxDecoration(
                        color: Palette.purple,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Color(0xffF2F2F2),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: BryteTypography.bodyRegular.copyWith(
                        color: Palette.purple,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      defaultTextStyle: BryteTypography.bodyRegular.copyWith(
                        color: const Color(
                          0xff9679C4,
                        ),
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  if (_selectedEvents.value.isNotEmpty &&
                      selectedValue.value == TabCalendarType.monthly)
                    EventDateLabel(selectedDay: _selectedDay),
                  if (_selectedEvents.value.isEmpty &&
                      selectedValue.value == TabCalendarType.monthly)
                    const NoEventCardCalendar(),
                  if (selectedValue.value == TabCalendarType.weekly)
                    (eventPerweek.every((element) => element.events.isEmpty))
                        ? const EveryEmptyEvent()
                        : WeeklyEventList(
                            eventPerweek: eventPerweek,
                            itemPositionsListener: itemPositionsListener,
                            itemScrollController: itemScrollController,
                          ),
                  if (selectedValue.value == TabCalendarType.monthly)
                    MonthlyEventList(selectedEvents: _selectedEvents),
                  const SizedBox(height: 100)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onPageChanged(DateTime focusedDay, String token, String userId) {
    _focusedDay = focusedDay;

    final last = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);

    DateTime first = DateTime(_focusedDay.year, _focusedDay.month, 1);

    eventBloc.add(
      GetCalendarEvent(
        EventBody(
          token: token,
          userid: userId,
          startDate: DateFormat('yyyy-MM-dd').format(first),
          endDate: DateFormat('yyyy-MM-dd').format(last),
        ),
      ),
    );

    week = getWeeksForRange(first, last);

    eventBloc.add(
      GetCalendarEventPerWeek(
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
        ),
      ),
    );

    log('rangeWeek $week');
  }

  CalendarBuilders<Event> _calendarBuilders() {
    return CalendarBuilders(
      markerBuilder: (BuildContext context, date, events) {
        bool eventAssignment =
            events.every((element) => element.type == 'assignment');

        bool eventClass = events.every((element) => element.type == 'class');

        if (events.isEmpty) return const SizedBox();
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: eventAssignment
              ? 1
              : eventClass
                  ? 1
                  : 2,
          itemBuilder: (context, index) {
            return events[index].type.contains('class')
                ? const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Icon(
                      Icons.school,
                      color: Palette.purple,
                      size: 15,
                    ),
                  )
                : events[index].type.contains('assignment')
                    ? const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.assignment,
                          size: 15,
                          color: Palette.darkPurple,
                        ),
                      )
                    : const SizedBox();
          },
        );
      },
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

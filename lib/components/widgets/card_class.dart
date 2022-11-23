// ignore_for_file: avoid_print

import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:bryte/core/blocs/attend/attend_bloc.dart';
import 'package:bryte/core/data/model/student/request/submit_attendance_body.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recase/recase.dart';

import '../utils/palette.dart';

class CardClasses extends StatelessWidget {
  const CardClasses({
    Key? key,
    required this.selected,
    required this.color1,
    required this.color2,
    required this.className,
    required this.absentTotal,
    required this.credits,
    required this.startTime,
    required this.endTime,
    required this.session,
    required this.absentLeft,
    required this.textColor1,
    required this.textColor2,
    required this.boxShadowColor,
    required this.status,
    required this.startTimeNoFormat,
    required this.endTimeNoFormat,
    required this.attendBloc,
    required this.userid,
    required this.sessionId,
    required this.attdStatusset,
    required this.attdStatus,
  }) : super(key: key);

  final bool selected;
  final Color color1;
  final Color color2;
  final String className;
  final int absentTotal;
  final String credits;
  final String startTime;
  final String endTime;
  final int session;
  final int absentLeft;
  final Color textColor1;
  final Color textColor2;
  final String status;
  final Color boxShadowColor;
  final String startTimeNoFormat;
  final String endTimeNoFormat;
  final String userid;
  final AttendBloc attendBloc;
  final String sessionId;
  final String attdStatusset;
  final String attdStatus;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final token = box.read(KeyConstant.token);

    var listAttdStatusset = attdStatusset.split(',');

    String presentId = listAttdStatusset.last;

    List<int> listAttdStatusInt = [
      int.parse(listAttdStatusset[0]),
      int.parse(listAttdStatusset[1]),
      int.parse(listAttdStatusset[2]),
      int.parse(listAttdStatusset[3]),
    ];

    TimeOfDay _startTime = TimeOfDay(
      hour: int.parse(startTime.split(":")[0]),
      minute: int.parse(startTime.split(":")[1]),
    );

    TimeOfDay _endTime = TimeOfDay(
      hour: int.parse(endTime.split(":")[0]),
      minute: int.parse(endTime.split(":")[1]),
    );

    bool isValidTimeRange(TimeOfDay startTime, TimeOfDay endTime) {
      TimeOfDay now = TimeOfDay.now();
      return ((now.hour > startTime.hour) ||
              (now.hour == startTime.hour && now.minute >= startTime.minute)) &&
          ((now.hour < endTime.hour) ||
              (now.hour == endTime.hour && now.minute <= endTime.minute));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 208,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: boxShadowColor,
                    offset: const Offset(0, 3),
                    spreadRadius: -3,
                    blurRadius: 10,
                  )
                ],
                color:
                    status == 'ongoing' ? Palette.purple : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 14,
                left: 4,
                right: 4,
                bottom: 4,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: color1,
              ),
              height: 198,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.school, color: Colors.white),
                            const SizedBox(width: 5),
                            Text(
                              'Class',
                              style: brytStyleWhite.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Text(
                          className,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: brytStyleWhite.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ABSENCE LEFT',
                                style: brytStyledarkGreen.copyWith(
                                    color: color2,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)),
                            Text(
                              '$absentLeft out of $absentTotal',
                              style: brytStyleWhite.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          child: VerticalDivider(
                            color: color2,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CREDITS',
                                style: brytStyledarkGreen.copyWith(
                                    color: color2,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)),
                            Text(
                              credits,
                              style: brytStyleWhite.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 63,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        color: color2,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: ReCase(status).headerCase,
                                    style: brytStyleWhite.copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  TextSpan(
                                    text: ' • $startTime - $endTime',
                                    style: brytStyleWhite.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('SESSION #$session',
                                style: brytStyleWhite.copyWith(
                                    fontSize: 11, fontWeight: FontWeight.w500))
                          ],
                        ),
                        if (isValidTimeRange(_startTime, _endTime) &&
                            attdStatus == 'W')
                          TextButton(
                            onPressed: () {
                              attendBloc.add(
                                SubmitAttendance(
                                  SubmitAttendanceBody(
                                    wstoken: token,
                                    wsfunction: SharedConstant.wsfunction,
                                    moodlewsrestformat:
                                        SharedConstant.moodlewsrestformat,
                                    sessionid: int.parse(sessionId),
                                    studentid: int.parse(userid),
                                    takenbyid: int.parse(userid),
                                    statusid: int.parse(presentId),
                                    statusset: listAttdStatusInt,
                                  ),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.white),
                            child: Text(
                              'ATTEND',
                              style: TextStyle(fontSize: 10, color: color2),
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (status == 'ongoing')
              Positioned(
                top: 0,
                left: 20,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: brytepurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Now',
                    style: brytStyleWhite.copyWith(fontSize: 10),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

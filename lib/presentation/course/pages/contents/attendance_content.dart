import 'dart:developer';

import 'package:bryte/core/blocs/attend/bloc/attend_list_bloc.dart';
import 'package:bryte/core/data/model/course/request/attendance_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

import 'package:bryte/core/blocs/attend/attend_bloc.dart';

import '../../../../components/utils/constant.dart';
import '../../../../components/utils/palette.dart';
import '../../../../components/utils/typography.dart';
import '../../../../core/data/model/student/request/submit_attendance_body.dart';

class AttendanceContent extends StatelessWidget {
  const AttendanceContent({
    Key? key,
    required this.attendBloc,
    required this.attendListBloc,
    required this.token,
    required this.userId,
    required this.idCourse,
  }) : super(key: key);

  final AttendBloc attendBloc;
  final AttendListBloc attendListBloc;
  final String token;
  final String userId;
  final String idCourse;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AttendBloc, AttendState>(
          listener: (context, state) {
            if (state is AttendFailure) {
              log('Get Attendance Failure');
            } else if (state is AttendSuccess) {
              attendListBloc.add(GetAttendListEvent(
                  body: AttendanceBody(
                      token: token, userid: userId, idCourse: idCourse)));
              Get.snackbar('Berhasil', 'Presensi telah dilakukan',
                  backgroundColor: Palette.green, colorText: Colors.white);
            }
          },
        ),
        BlocListener<AttendListBloc, AttendListState>(
          listener: (context, state) {
            log('get attend list success');
          },
        ),
      ],
      child: BlocBuilder<AttendListBloc, AttendListState>(
        builder: (context, state) {
          if (state is AttendListSuccess) {
            return _buildAttendanceCourse(state);
          } else if (state is AttendListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Column _buildAttendanceCourse(AttendListSuccess state) {
    final box = GetStorage();

    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            'Attendance',
            style: BryteTypography.headerExtraBold.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: const Color(0xff333333)),
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Palette.lightPurple),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          'Absence Left',
                          style: BryteTypography.headerSemiBold.copyWith(
                              color: const Color(0xff5F5F5F),
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          state.response.data[0].attendanceHead[0].absence
                              .toString(),
                          style: BryteTypography.headerExtraBold.copyWith(
                              fontSize: 24,
                              color: Palette.purple,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Palette.lightPurple),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        Text('Attendance',
                            style: BryteTypography.headerSemiBold.copyWith(
                                color: const Color(0xff5F5F5F),
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                        Text(
                            state.response.data[0].attendanceHead[0].attendance,
                            style: BryteTypography.headerExtraBold.copyWith(
                                fontSize: 24,
                                color: Palette.purple,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Full Report',
            style: BryteTypography.headerSemiBold.copyWith(
                color: const Color(0xff5F5F5F),
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
        ),
        Column(
          children: state.response.data[0].attendanceDetail
              .map(
                (e) => Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          e.attdSessDescp,
                          style: BryteTypography.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '${DateFormat('EEE dd MMM yyyy').format(DateTime.parse(e.attdEndDate))} ${DateFormat('HHa').format(DateTime.parse(e.attdStartDate))}-${DateFormat('HH:mma').format(DateTime.parse(e.attdEndDate))}',
                              style: BryteTypography.titleMedium.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: const Color(0xff000000).withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 10,)
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: e.attdAcronym == 'W'
                            ? () {
                                attendBloc.add(SubmitAttendance(
                                  SubmitAttendanceBody(
                                    wstoken: token,
                                    wsfunction: SharedConstant.wsfunction,
                                    moodlewsrestformat:
                                        SharedConstant.moodlewsrestformat,
                                    sessionid: int.parse(e.idAttdSes),
                                    studentid: int.parse(userId),
                                    takenbyid: int.parse(userId),
                                    statusid: int.parse(
                                        e.attdStatusset[0].idStatusset),
                                    statusset: e.attdStatusset
                                        .map((e) => int.parse(e.idStatusset))
                                        .toList(),
                                  ),
                                ));
                              }
                            : null,
                        child: Container(
                          width: 85,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: e.attdAcronym == 'W'
                                  ? Palette.purple
                                  : Palette.lightGrey.withOpacity(0.2)),
                          child: Text(
                            ReCase(
                              e.attdAcronym == 'W' ? 'ATTEND' : e.attdStatus,
                            ).constantCase,
                            style: BryteTypography.bodyMedium.copyWith(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: e.attdAcronym == 'P'
                                  ? Palette.green
                                  : e.attdAcronym == 'W'
                                      ? Colors.white
                                      : Palette.lightGrey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

import 'dart:developer';

import 'package:bryte/core/blocs/attend/attend_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/utils/palette.dart';
import '../../../../components/utils/typography.dart';
import '../course_section_page.dart';

class AttendanceContent extends StatelessWidget {
  const AttendanceContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendBloc, AttendState>(
      listener: (context, state) {
        if (state is AttendanceCourseSuccess) {
          log('Get Attendance Success');
        } else if (state is AttendFailure) {
          log('Get Attendance Failure');
        }
      },
      builder: (context, state) {
        if (state is AttendanceCourseSuccess) {
          return _buildAttendanceCourse(state);
        } else if (state is AttendLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('Something Error'),
          );
        }
      },
    );
  }

  Column _buildAttendanceCourse(AttendanceCourseSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            'Attendances',
            style: BryteTypography.headerExtraBold,
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
                        const Text(
                          'Absence Left',
                          style: BryteTypography.headerSemiBold,
                        ),
                        Text(
                          state.response.data[0].attendanceHead[0].absence
                              .toString(),
                          style: BryteTypography.headerExtraBold
                              .copyWith(fontSize: 20, color: Palette.purple),
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
                        const Text(
                          'Attendance',
                          style: BryteTypography.headerSemiBold,
                        ),
                        Text(
                          state.response.data[0].attendanceHead[0].attendance,
                          style: BryteTypography.headerExtraBold
                              .copyWith(fontSize: 20, color: Palette.purple),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Full Report',
            style: BryteTypography.headerSemiBold,
          ),
        ),
        Column(
          children: reportList
              .map(
                (e) => Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Text(e.weekNumber)),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              e.date,
                            ),
                            Text(
                              e.time,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: e.statusAttend == 'WAITING' ? () {} : null,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: e.statusAttend == 'WAITING'
                                  ? Palette.purple
                                  : Palette.lightGrey.withOpacity(0.2)),
                          child: Text(
                            e.statusAttend == 'WAITING'
                                ? 'ATTEND'
                                : e.statusAttend,
                            style: BryteTypography.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: e.statusAttend == 'PRESENT'
                                    ? Palette.green
                                    : e.statusAttend == 'WAITING'
                                        ? Colors.white
                                        : Palette.lightGrey),
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

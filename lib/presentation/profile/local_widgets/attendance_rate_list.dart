import 'package:bryte/core/data/model/profile/response/attendance_rate_student_model.dart';
import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';

class AttendanceRateList extends StatelessWidget {
  const AttendanceRateList({
    Key? key,
    required this.attendanceRateStudents,
  }) : super(key: key);

  final List<DataAttendanceRateStudentModel> attendanceRateStudents;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        attendanceRateStudents.length,
        (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        attendanceRateStudents[0].academicPeriod == null
                            ? ''
                            : attendanceRateStudents[0].academicPeriod!,
                        style: BryteTypography.titleSemiBold.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      Text(
                        ' • '
                        '${attendanceRateStudents[0].attendance == null ? '' : attendanceRateStudents[0].attendance![0].currentSksTot}'
                        ' credits',
                        style: BryteTypography.titleSemiBold.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    attendanceRateStudents[0].attendance == null
                        ? ''
                        : attendanceRateStudents[0]
                            .attendance![0]
                            .currentAttdRate,
                    style: BryteTypography.titleSemiBold.copyWith(
                      color: Palette.purple,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    attendanceRateStudents[0].attendance == null
                        ? 0
                        : attendanceRateStudents[0]
                            .attendance![0]
                            .details
                            .length,
                    (i) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${attendanceRateStudents[0].attendance![0].details[i].courseName} • ${attendanceRateStudents[0].attendance![0].details[i].sks}',
                                style: BryteTypography.bodyRegular.copyWith(
                                  color: const Color(0xffA2A2A2),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              attendanceRateStudents[0]
                                  .attendance![0]
                                  .details[i]
                                  .attdRate,
                              style: BryteTypography.titleSemiBold.copyWith(
                                  color: Palette.purple,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ],
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

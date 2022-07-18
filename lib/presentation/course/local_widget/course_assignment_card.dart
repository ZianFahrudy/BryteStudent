import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:bryte/core/data/model/course/response/assignment_model.dart';
import 'package:bryte/presentation/course/pages/detail_assignment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardCourseAssignment extends StatelessWidget {
  const CardCourseAssignment({
    Key? key,
    required this.data,
    required this.selecteAssignSection,
  }) : super(key: key);

  final DataAssignmentModel data;
  final ValueNotifier<int> selecteAssignSection;

  @override
  Widget build(BuildContext context) {
    final dateTimeNow = DateFormat('dd MMMM').format(DateTime.now());
    final compareDueDate =
        DateFormat('dd MMMM').format(DateTime.parse(data.assignDeadline));
    final dueDate =
        DateFormat('dd MMM').format(DateTime.parse(data.assignDeadline));

    final now = DateTime.now();

    final tomorrow =
        DateFormat('dd MMMM').format(now.subtract(const Duration(days: 1)));

    final timeDeadline =
        DateFormat('HH:mm').format(DateTime.parse(data.assignDeadline));

    return SizedBox(
      child: Card(
        shadowColor: Palette.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: InkWell(
          onTap: () => Get.to(() => DetailAssignmentPage(
                idAssign: data.idAssign,
                idCourse: data.idCourse,
                teacherName: 'dummy',
                selectedSection: selecteAssignSection,
                bgColor: data.bgColor_1,
                courseAssignName: data.assignName,
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          dateTimeNow == compareDueDate
                              ? 'Today'
                              : tomorrow == compareDueDate
                                  ? 'Tomorrow'
                                  : dueDate,
                          style: brytStyleJudul.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          timeDeadline,
                          style: brytStyleJudul.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 2,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      color: Palette.secondary,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Text(
                          data.courseName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: brytStylebtn.copyWith(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: Color(int.parse(
                                    data.bgColor_2.replaceAll('#', '0xff'))),
                                borderRadius: BorderRadius.circular(3)),
                          ),
                          Flexible(
                            child: Text(
                              data.assignName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: brytStyleJudul.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Palette.lightGrey,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    data.assignStatus == AssignStatus.submitted
                        ? 'SUBMITTED'
                        : data.assignStatus == AssignStatus.notAttempted
                            ? 'NOT ATTEMPTED'
                            : 'LATE',
                    style: brytStyleJudul.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: data.assignStatus == AssignStatus.submitted
                          ? Palette.sprite500
                          : data.assignStatus == AssignStatus.notAttempted
                              ? Palette.red
                              : Palette.sunkist500,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: data.assignStatus == AssignStatus.submitted
                          ? Palette.sprite200.withOpacity(0.5)
                          : data.assignStatus == AssignStatus.notAttempted
                              ? Palette.coke200.withOpacity(0.5)
                              : Palette.sunkist200),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AssignStatus {
  static const submitted = 'SUBMITTED';
  static const notAttempted = 'NOT ATTEMPTED';
  static const lated = 'LATE';
}

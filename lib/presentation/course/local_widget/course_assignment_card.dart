import 'package:bryte/components/utils/hex_color.dart';
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

    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 12),
      child: Stack(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            shadowColor: Palette.secondary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: dateTimeNow == compareDueDate
                                      ? const Color(0xffFF5858)
                                      : tomorrow == compareDueDate
                                          ? Palette.purple
                                          : Palette.purple),
                            ),
                            Text(timeDeadline,
                                style: brytStyleJudul.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: dateTimeNow == compareDueDate
                                        ? const Color(0xffFF5858)
                                        : tomorrow == compareDueDate
                                            ? Palette.purple
                                            : Palette.purple)),
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
                                  color:
                                      const Color(0xff000000).withOpacity(0.6),
                                  fontWeight: FontWeight.w600),
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
                                  color: HexColor(data.bgColor_2),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  data.assignName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: brytStyleJudul.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff969696),
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
                      width: 99,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 5),
                      child: Text(
                        data.assignStatus == AssignStatus.submitted
                            ? 'SUBMITTED'
                            : data.assignStatus == AssignStatus.notAttempted
                                ? 'NOT ATTEMPTED'
                                : 'LATE',
                        style: brytStyleJudul.copyWith(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: data.assignStatus == AssignStatus.submitted
                              ? Palette.sprite500
                              : data.assignStatus ==
                                          AssignStatus.notAttempted &&
                                      dateTimeNow == compareDueDate
                                  ? Palette.red
                                  : data.assignStatus ==
                                          AssignStatus.notAttempted
                                      ? const Color(0xffA2A2A2)
                                      : Palette.sunkist500,
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: data.assignStatus == AssignStatus.submitted
                              ? Palette.sprite200.withOpacity(0.5)
                              : data.assignStatus ==
                                          AssignStatus.notAttempted &&
                                      dateTimeNow == compareDueDate
                                  ? Palette.coke200.withOpacity(0.5)
                                  : data.assignStatus ==
                                          AssignStatus.notAttempted
                                      ? const Color(0xffE7E7E7)
                                      : Palette.sunkist200),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (dateTimeNow == compareDueDate)
            const Positioned(
              top: 25,
              bottom: 25,
              child: Padding(
                padding: EdgeInsets.only(left: 1),
                child: Icon(
                  Icons.info_sharp,
                  color: Colors.red,
                ),
              ),
            )
        ],
      ),
    );
  }
}

class AssignStatus {
  static const submitted = 'SUBMITTED';
  static const notAttempted = 'NOT ATTEMPTED';
  static const lated = 'LATE';
}

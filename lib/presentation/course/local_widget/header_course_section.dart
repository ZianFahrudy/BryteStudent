import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';
import 'course_tab_button.dart';

class HeaderCourseSection extends StatelessWidget {
  const HeaderCourseSection({
    Key? key,
    required this.selectedSection,
    this.isMain = false,
    this.onTapScore,
    this.onTapGeneral,
    this.onTapAssignment,
    this.onTapParticipant,
    this.onTapAttendance,
    required this.courseAssignName,
    required this.teacherName,
    required this.bgColor,
    // required this.dataCourse,
  }) : super(key: key);

  final ValueNotifier<int> selectedSection;
  final bool? isMain;
  final Function()? onTapGeneral;
  final Function()? onTapScore;
  final Function()? onTapAssignment;
  final Function()? onTapParticipant;
  final Function()? onTapAttendance;
  final String courseAssignName;
  final String teacherName;
  final String bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 121,
      color: Color(
        int.parse(
          bgColor.replaceAll('#', '0xff'),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(.2),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        Color(int.parse(bgColor.replaceAll('#', '0xff'))),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseAssignName,
                        style: BryteTypography.headerExtraBold.copyWith(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        teacherName,
                        style: BryteTypography.titleMedium.copyWith(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black.withOpacity(.2)),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Section',
                        style: BryteTypography.titleMedium
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: isMain!
                            ? onTapGeneral
                            : () {
                                selectedSection.value = 0;
                              },
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                'General',
                                style: BryteTypography.titleSemiBold.copyWith(
                                  color: selectedSection.value == 0
                                      ? Colors.black
                                      : Palette.grey,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 25,
                                width: 2,
                                color: Palette.orange,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.black.withOpacity(.2),
                        width: 2,
                      ),
                      Row(
                        children: [
                          CourseTabButton(
                            label: 'Assignments',
                            color: selectedSection.value == 1
                                ? Colors.black
                                : Palette.grey,
                            onTap: isMain!
                                ? onTapAssignment
                                : () {
                                    selectedSection.value = 1;
                                  },
                          ),
                          CourseTabButton(
                            label: 'Attendances',
                            color: selectedSection.value == 2
                                ? Colors.black
                                : Palette.grey,
                            onTap: isMain!
                                ? onTapAttendance
                                : () {
                                    selectedSection.value = 2;
                                  },
                          ),
                          CourseTabButton(
                            label: 'Scores',
                            color: selectedSection.value == 3
                                ? Colors.black
                                : Palette.grey,
                            onTap: isMain!
                                ? onTapScore
                                : () {
                                    selectedSection.value = 3;
                                  },
                          ),
                          CourseTabButton(
                            label: 'Participants',
                            color: selectedSection.value == 4
                                ? Colors.black
                                : Palette.grey,
                            onTap: isMain!
                                ? onTapParticipant
                                : () {
                                    selectedSection.value = 4;
                                  },
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

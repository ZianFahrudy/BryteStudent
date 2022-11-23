import 'package:bryte/components/utils/hex_color.dart';
import 'package:bryte/presentation/course/local_widget/dropdown_general_section.dart';
import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';
import 'course_tab_button.dart';

class HeaderCourseSection extends StatefulWidget {
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
    required this.idCourse,
    this.onChanged,
    required this.selectedValue,
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
  final String idCourse;
  final Function(String?)? onChanged;
  final ValueNotifier<String> selectedValue;

  @override
  State<HeaderCourseSection> createState() => _HeaderCourseSectionState();
}

class _HeaderCourseSectionState extends State<HeaderCourseSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 121,
      color: HexColor(widget.bgColor),
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
                      radius: 20, backgroundColor: HexColor(widget.bgColor)),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.courseAssignName,
                        style: BryteTypography.headerExtraBold.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.teacherName,
                        style: BryteTypography.titleMedium.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
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
                        style: BryteTypography.titleMedium.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: widget.isMain!
                            ? widget.onTapGeneral
                            : () {
                                widget.selectedSection.value = 0;
                              },
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Text(
                                'General',
                                style: BryteTypography.titleSemiBold.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: widget.selectedSection.value == 0
                                      ? Colors.black
                                      : Palette.grey,
                                ),
                              ),
                              const VerticalDivider(
                                thickness: 1,
                                color: Color(0xffFFBC58),
                              ),
                              DropdownGeneralSection(
                                  onChanged: widget.onChanged,
                                  selectedValue: widget.selectedValue,
                                  idCourse: widget.idCourse),
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
                            color: widget.selectedSection.value == 1
                                ? Colors.black
                                : Palette.grey,
                            onTap: widget.isMain!
                                ? widget.onTapAssignment
                                : () {
                                    widget.selectedSection.value = 1;
                                  },
                          ),
                          CourseTabButton(
                            label: 'Attendances',
                            color: widget.selectedSection.value == 2
                                ? Colors.black
                                : Palette.grey,
                            onTap: widget.isMain!
                                ? widget.onTapAttendance
                                : () {
                                    widget.selectedSection.value = 2;
                                  },
                          ),
                          CourseTabButton(
                            label: 'Scores',
                            color: widget.selectedSection.value == 3
                                ? Colors.black
                                : Palette.grey,
                            onTap: widget.isMain!
                                ? widget.onTapScore
                                : () {
                                    widget.selectedSection.value = 3;
                                  },
                          ),
                          CourseTabButton(
                            label: 'Participants',
                            color: widget.selectedSection.value == 4
                                ? Colors.black
                                : Palette.grey,
                            onTap: widget.isMain!
                                ? widget.onTapParticipant
                                : () {
                                    widget.selectedSection.value = 4;
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

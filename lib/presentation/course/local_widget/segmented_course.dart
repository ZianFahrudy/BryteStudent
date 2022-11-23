import 'dart:developer';
import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:bryte/core/blocs/assignment/assignment_bloc.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/presentation/course/pages/course_page.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';

import '../../navigation/cubits/nav_course/nav_course_cubit.dart';

class SegmentedCourse extends StatelessWidget {
  const SegmentedCourse({
    Key? key,
    required this.selectedValue,
    required this.courseBloc,
    required this.selectedFilterValue,
    required this.assignmentBloc,
    required this.selectedFilterAssign,
    required this.navCourseCubit,
  }) : super(key: key);

  final ValueNotifier<TabType?> selectedValue;
  final CourseBloc courseBloc;
  final AssignmentBloc assignmentBloc;
  final ValueNotifier<FilterCourseType> selectedFilterValue;
  final ValueNotifier<FilterAssignmentType> selectedFilterAssign;
  final NavCourseCubit navCourseCubit;

  @override
  Widget build(BuildContext context) {
    // final box = GetStorage();

    // final token = box.read(KeyConstant.token);
    // final userId = box.read(KeyConstant.userId);

    final controller = CustomSegmentedController<bool>();

    return ValueListenableBuilder(
      valueListenable: selectedFilterValue,
      builder: (context, _, __) => Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CustomSlidingSegmentedControl<bool>(
                height: 30,
                innerPadding: const EdgeInsets.all(0),
                children: {
                  navCourseCubit.isCourse: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Courses',
                      style: brytStylebtn.copyWith(
                          color: !navCourseCubit.isCourse
                              ? Palette.headerSpecial
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  !navCourseCubit.isCourse: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Assigments',
                      style: brytStylebtn.copyWith(
                          color: navCourseCubit.isCourse
                              ? Palette.darkPurple
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                },
                decoration: BoxDecoration(
                  color: Palette.secondary,
                  borderRadius: BorderRadius.circular(27),
                ),
                initialValue: navCourseCubit.isCourse,
                thumbDecoration: BoxDecoration(
                  color: navCourseCubit.isCourse &&
                          selectedValue.value == TabType.course
                      ? Palette.headerSpecial
                      : Colors.transparent,
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
                controller: controller,
                onValueChanged: (bool value) {
                  // value = false;

                  // selectedValue.value = value;
                  // if (navCourseCubit.isCourse) {
                  //   selectedValue.value = TabType.course;
                  // } else {
                  //   selectedValue.value = TabType.assignments;
                  // }

                  log(value.toString(), name: 'VALUE');

                  // selectedValue.value = value;

                  // if (selectedValue.value == TabType.course) {
                  //   navCourseCubit.toCourseTab();
                  //   courseBloc.add(GetCourseEvent(
                  //     body: CourseBody(
                  //       token: token,
                  //       userid: userId,
                  //       type: selectedFilterValue.value ==
                  //               FilterCourseType.inProgress
                  //           ? 'progress'
                  //           : selectedFilterValue.value == FilterCourseType.past
                  //               ? 'past'
                  //               : 'future',
                  //     ),
                  //   ));
                  // } else {
                  //   navCourseCubit.toAssignmentTab();
                  //   assignmentBloc.add(
                  //     GetCourseAssignment(
                  //       body: CourseBody(
                  //         token: token,
                  //         userid: userId,
                  //         type: selectedFilterAssign.value ==
                  //                 FilterAssignmentType.allUpcoming
                  //             ? 'upcoming'
                  //             : selectedFilterAssign.value ==
                  //                     FilterAssignmentType.thisWeek
                  //                 ? 'weekly'
                  //                 : 'past',
                  //       ),
                  //     ),
                  //   );
                  // }
                },
              )),
          const Divider(
            thickness: 1,
            height: 0,
          ),
        ],
      ),
    );
  }
}

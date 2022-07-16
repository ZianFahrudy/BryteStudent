import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/data/model/course/request/course_body.dart';
import 'package:bryte/presentation/course/pages/course_page.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../components/utils/constant.dart';

class SegmentedCourse extends StatelessWidget {
  const SegmentedCourse({
    Key? key,
    required this.selectedValue,
    required this.courseBloc,
    required this.selectedFilterValue,
  }) : super(key: key);

  final ValueNotifier<TabType> selectedValue;
  final CourseBloc courseBloc;
  final ValueNotifier<FilterCourseType> selectedFilterValue;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);
    return ValueListenableBuilder(
      valueListenable: selectedFilterValue,
      builder: (context, _, __) => Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CustomSlidingSegmentedControl<TabType>(
                height: 30,
                innerPadding: const EdgeInsets.all(0),
                children: {
                  TabType.course: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Courses',
                      style: brytStylebtn.copyWith(
                          color: selectedValue.value == TabType.assignments
                              ? Palette.headerSpecial
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TabType.assignments: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Assigments',
                      style: brytStylebtn.copyWith(
                          color: selectedValue.value == TabType.course
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
                thumbDecoration: BoxDecoration(
                  color: Palette.headerSpecial,
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
                onValueChanged: (TabType value) {
                  selectedValue.value = value;

                  courseBloc.add(GetCourseEvent(
                    body: CourseBody(
                      token: token,
                      userid: userId,
                      type: selectedFilterValue.value ==
                              FilterCourseType.inProgress
                          ? 'progress'
                          : selectedFilterValue.value == FilterCourseType.past
                              ? 'past'
                              : 'future',
                    ),
                  ));
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

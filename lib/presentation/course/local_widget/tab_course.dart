import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/widgets/filter_courses.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/data/model/course/request/course_body.dart';
import 'package:bryte/presentation/course/pages/course_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../components/utils/constant.dart';

class TabCourse extends StatelessWidget {
  const TabCourse({
    Key? key,
    required this.selectedFilterValue,
    required this.courseBloc,
  }) : super(key: key);

  final ValueNotifier<FilterCourseType> selectedFilterValue;
  final CourseBloc courseBloc;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterCourses(
            onTap: () {
              selectedFilterValue.value = FilterCourseType.inProgress;
              courseBloc.add(
                GetCourseEvent(
                  body: CourseBody(
                      token: token, userid: userId, type: 'progress'),
                ),
              );
            },
            color: selectedFilterValue.value == FilterCourseType.past
                ? Palette.lighterGrey
                : selectedFilterValue.value == FilterCourseType.future
                    ? Palette.lighterGrey
                    : Palette.purple,
            textColor: selectedFilterValue.value == FilterCourseType.past
                ? Palette.lightGrey
                : selectedFilterValue.value == FilterCourseType.future
                    ? Palette.lightGrey
                    : Colors.white,
            label: 'In Progress',
          ),
          const SizedBox(
            width: 13,
          ),
          FilterCourses(
            onTap: () {
              selectedFilterValue.value = FilterCourseType.past;
              courseBloc.add(GetCourseEvent(
                  body:
                      CourseBody(token: token, userid: userId, type: 'past')));
            },
            color: selectedFilterValue.value == FilterCourseType.inProgress
                ? Palette.lighterGrey
                : selectedFilterValue.value == FilterCourseType.future
                    ? Palette.lighterGrey
                    : Palette.purple,
            textColor: selectedFilterValue.value == FilterCourseType.inProgress
                ? Palette.lightGrey
                : selectedFilterValue.value == FilterCourseType.future
                    ? Palette.lightGrey
                    : Colors.white,
            label: 'Past',
          ),
          const SizedBox(
            width: 13,
          ),
          FilterCourses(
            onTap: () {
              selectedFilterValue.value = FilterCourseType.future;
              courseBloc.add(
                GetCourseEvent(
                  body: CourseBody(
                    token: token,
                    userid: userId,
                    type: 'future',
                  ),
                ),
              );
            },
            color: selectedFilterValue.value == FilterCourseType.inProgress
                ? Palette.lighterGrey
                : selectedFilterValue.value == FilterCourseType.past
                    ? Palette.lighterGrey
                    : Palette.purple,
            textColor: selectedFilterValue.value == FilterCourseType.inProgress
                ? Palette.lightGrey
                : selectedFilterValue.value == FilterCourseType.past
                    ? Palette.lightGrey
                    : Colors.white,
            label: 'Future',
          ),
        ],
      ),
    );
  }
}

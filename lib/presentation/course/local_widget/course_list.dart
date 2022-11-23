import 'dart:developer';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/data/model/course/response/course_model.dart';
import 'package:bryte/presentation/course/local_widget/tab_course.dart';
import 'package:bryte/presentation/course/pages/course_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_bryte_list.dart';
import 'empty_course_bryte.dart';

class CourseList extends StatefulWidget {
  const CourseList({
    Key? key,
    required this.selectedFilterValue,
    required this.courseBloc,
  }) : super(key: key);

  final ValueNotifier<FilterCourseType> selectedFilterValue;
  final CourseBloc courseBloc;

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  var data = <DataCourseModel>[];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is CourseStudentSuccess) {
          log('Course Student Success');
          data = state.response.data;
        } else if (state is CourseFailed) {
          log('Course Student Gagal');
        } else if (state is CourseAssignmentSuccess) {
          log('Asignment Success');
        }
      },
      builder: (context, state) {
        return ValueListenableBuilder<FilterCourseType>(
          valueListenable: widget.selectedFilterValue,
          builder: (context, value, _) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabCourse(
                  selectedFilterValue: widget.selectedFilterValue,
                  courseBloc: widget.courseBloc,
                ),
                data.isEmpty
                    ? const EmptyCourseBryte()
                    : CourseBryteList(
                        data: data,
                        selectedFilterValue: widget.selectedFilterValue,
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}

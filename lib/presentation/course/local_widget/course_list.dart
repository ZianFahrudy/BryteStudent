import 'dart:developer';
import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/data/model/course/response/course_model.dart';
import 'package:bryte/presentation/course/local_widget/course_card.dart';
import 'package:bryte/presentation/course/local_widget/tab_course.dart';
import 'package:bryte/presentation/course/pages/course_page.dart';
import 'package:bryte/presentation/course/pages/course_section_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
                    ? Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: Image.asset(
                              AssetConstant.emptyCourseAssignmentMan),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          data.length,
                          (index) => CourseCard(
                            onTap: () => Get.to(
                              () => SectionGeneralPage(
                                dataCourse: data[index],
                              ),
                            ),
                            shadowColor: Color(
                              int.parse(
                                data[index].dropShadow.replaceAll('#', '0xff'),
                              ),
                            ),
                            name: data[index].teacherName,
                            title: data[index].course,
                            color: Color(
                              int.parse(
                                data[index].bgColor_1.replaceAll('#', '0xff'),
                              ),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}

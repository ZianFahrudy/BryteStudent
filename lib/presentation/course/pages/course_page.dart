import 'package:bryte/core/blocs/assignment/assignment_bloc.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/data/model/course/request/course_body.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/course/local_widget/assigment_list.dart';
import 'package:bryte/presentation/course/local_widget/course_list.dart';
import 'package:bryte/presentation/course/local_widget/segmented_course.dart';
import 'package:flutter/material.dart';

import 'package:bryte/components/utils/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

enum TabType { course, assignments }

enum FilterCourseType { inProgress, past, future }

enum FilterAssignmentType { allUpcoming, thisWeek, pastDue }

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final selectedValue = ValueNotifier<TabType>(TabType.course);
    final selectedFilterValue =
        ValueNotifier<FilterCourseType>(FilterCourseType.inProgress);
    final selectedFilterAssignment =
        ValueNotifier<FilterAssignmentType>(FilterAssignmentType.allUpcoming);

    final courseBloc = getIt<CourseBloc>();
    final assignmentBloc = getIt<AssignmentBloc>();

    final selectedSection = ValueNotifier<int>(1);

    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(AssetConstant.bryteLogoWhite),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => courseBloc
                ..add(
                  GetCourseEvent(
                    body: CourseBody(
                      token: token,
                      userid: userId,
                      type: 'progress',
                    ),
                  ),
                )),
          BlocProvider(
            create: (context) => assignmentBloc
              ..add(
                GetCourseAssignment(
                  body: CourseBody(
                    token: token,
                    userid: userId,
                    type: 'upcoming',
                  ),
                ),
              ),
          ),
        ],
        child: ValueListenableBuilder<TabType>(
          valueListenable: selectedValue,
          builder: (context, value, _) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SegmentedCourse(
                  selectedValue: selectedValue,
                  courseBloc: courseBloc,
                  selectedFilterValue: selectedFilterValue,
                ),
                if (value == TabType.course)
                  CourseList(
                    selectedFilterValue: selectedFilterValue,
                    courseBloc: courseBloc,
                  ),
                if (value == TabType.assignments)
                  AssignmentList(
                    selectedFilterAssignment: selectedFilterAssignment,
                    assignmentBloc: assignmentBloc,
                    selectedSection: selectedSection,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseModelDummy {
  final String title;
  final String teacher;
  final Color color;
  final bool newChanges;
  CourseModelDummy({
    required this.title,
    required this.teacher,
    required this.color,
    required this.newChanges,
  });
}

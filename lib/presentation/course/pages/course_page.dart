import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/assignment/assignment_bloc.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/data/model/course/request/course_body.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/course/local_widget/assigment_list.dart';
import 'package:bryte/presentation/course/local_widget/course_list.dart';
import 'package:flutter/material.dart';
import 'package:bryte/components/utils/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../navigation/cubits/nav_course/nav_course_cubit.dart';

enum TabType { course, assignments }

enum FilterCourseType { inProgress, past, future }

enum FilterAssignmentType { allUpcoming, thisWeek, pastDue }

class CoursePage extends StatefulWidget {
  const CoursePage({
    Key? key,
    required this.selectedIndex,
    required this.navCourseCubit,
  }) : super(key: key);

  final ValueNotifier<int> selectedIndex;
  final NavCourseCubit navCourseCubit;

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final box = GetStorage();
  final selectedFilterValue =
      ValueNotifier<FilterCourseType>(FilterCourseType.inProgress);
  final selectedFilterAssignment =
      ValueNotifier<FilterAssignmentType>(FilterAssignmentType.allUpcoming);
  final courseBloc = getIt<CourseBloc>();
  final assignmentBloc = getIt<AssignmentBloc>();
  final selectedSection = ValueNotifier<int>(1);
  // final navCourseCubit = getIt<NavCourseCubit>();

  final selectedValue = ValueNotifier<TabType?>(null);

  @override
  void initState() {
    widget.navCourseCubit.toCourseTab();
    selectedValue.value = TabType.assignments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff58329C).withOpacity(0.8),
        title: Image.asset(
          AssetConstant.bryteLogoWhite,
          width: 59,
        ),
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
          BlocProvider(
            create: (context) => widget.navCourseCubit,
          ),
        ],
        child: BlocListener<NavCourseCubit, NavCourseState>(
          listener: (context, state) {
            if (state is NavCourseSuccess) {
              selectedFilterValue.value = FilterCourseType.inProgress;
              selectedFilterAssignment.value = FilterAssignmentType.allUpcoming;
              courseBloc.add(
                GetCourseEvent(
                  body: CourseBody(
                    token: token,
                    userid: userId,
                    type: 'progress',
                  ),
                ),
              );
              assignmentBloc.add(
                GetCourseAssignment(
                  body: CourseBody(
                    token: token,
                    userid: userId,
                    type: 'upcoming',
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<NavCourseCubit, NavCourseState>(
            builder: (context, state) {
              if (state is NavCourseSuccess) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _segmentedCourseCustome(token, userId),
                      const Divider(
                        height: 0,
                        thickness: 1,
                      ),
                      if (state.isCourse)
                        CourseList(
                          selectedFilterValue: selectedFilterValue,
                          courseBloc: courseBloc,
                        ),
                      if (!state.isCourse)
                        AssignmentList(
                          selectedFilterAssignment: selectedFilterAssignment,
                          assignmentBloc: assignmentBloc,
                          selectedSection: selectedSection,
                        ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Container _segmentedCourseCustome(token, userId) {
    return Container(
      height: 30,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 13),
      decoration: BoxDecoration(
          color: const Color(0xffF3EDFF),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 30,
              decoration: BoxDecoration(
                  color: !widget.navCourseCubit.isCourse
                      ? Colors.transparent
                      : Palette.darkPurple,
                  borderRadius: BorderRadius.circular(25)),
              child: InkWell(
                onTap: () {
                  widget.navCourseCubit.toCourseTab();
                  courseBloc.add(
                    GetCourseEvent(
                      body: CourseBody(
                        token: token,
                        userid: userId,
                        type: 'progress',
                      ),
                    ),
                  );
                },
                child: Text(
                  'Courses',
                  style: BryteTypography.bodyMedium.copyWith(
                    color: !widget.navCourseCubit.isCourse
                        ? Palette.darkPurple
                        : Colors.white,
                    fontSize: 14,
                    fontFamily: 'SF Pro Bold',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 30,
              decoration: BoxDecoration(
                  color: widget.navCourseCubit.isCourse
                      ? Colors.transparent
                      : Palette.darkPurple,
                  borderRadius: BorderRadius.circular(25)),
              child: InkWell(
                  onTap: () {
                    widget.navCourseCubit.toAssignmentTab();
                    assignmentBloc.add(
                      GetCourseAssignment(
                        body: CourseBody(
                          token: token,
                          userid: userId,
                          type: 'upcoming',
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Assigments',
                    style: BryteTypography.bodyMedium.copyWith(
                      color: widget.navCourseCubit.isCourse
                          ? Palette.darkPurple
                          : Colors.white,
                      fontSize: 14,
                      fontFamily: 'SF Pro Bold',
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

import '../../../components/utils/palette.dart';
import '../../../components/widgets/filter_courses.dart';

enum TabType { course, assignments }
enum FilterCourseType { inProgress, past, future }
enum FilterAssignmentType { allUpcoming, thisWeek, pastDue }

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    final selectedValue = ValueNotifier<TabType>(TabType.course);
    final selectedFilterValue =
        ValueNotifier<FilterCourseType>(FilterCourseType.inProgress);
    final selectedFilterAssignment =
        ValueNotifier<FilterAssignmentType>(FilterAssignmentType.allUpcoming);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(AssetConstant.bryteLogoWhite),
        ),
        body: ValueListenableBuilder<TabType>(
          valueListenable: selectedValue,
          builder: (context, value, _) => SingleChildScrollView(
            child: Column(
              children: [
                SegmentedCourse(selectedValue: selectedValue),
                if (value == TabType.course)
                  CourseList(selectedFilterValue: selectedFilterValue),
                if (value == TabType.assignments)
                  AssignmentList(
                      selectedFilterAssignment: selectedFilterAssignment),
              ],
            ),
          ),
        ));
  }
}

class AssignmentList extends StatelessWidget {
  const AssignmentList({
    Key? key,
    required this.selectedFilterAssignment,
  }) : super(key: key);

  final ValueNotifier<FilterAssignmentType> selectedFilterAssignment;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FilterAssignmentType>(
      valueListenable: selectedFilterAssignment,
      builder: (context, value, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabAssignment(selectedFilterAssignment: selectedFilterAssignment),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  List.generate(5, (index) => const CardCourseAssignment()),
            )
          ],
        ),
      ),
    );
  }
}

class CardCourseAssignment extends StatelessWidget {
  const CardCourseAssignment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Palette.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  'Today',
                  style: brytStyleJudul.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '23:59',
                  style: brytStyleJudul.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            // SizedBox(width: 20),
            Container(
              width: 2,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              color: Palette.secondary,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quiz Week 1',
                  style: brytStylebtn.copyWith(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Container(
                      height: 11,
                      width: 11,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Palette.green),
                    ),
                    Text(
                      'Design Project IV',
                      style: brytStyleJudul.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Palette.lightGrey),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                'SUBMITTED',
                style: brytStyleJudul.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Palette.darkPurple),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Palette.secondary.withOpacity(0.8)),
            )
          ],
        ),
      ),
    );
  }
}

class TabAssignment extends StatelessWidget {
  const TabAssignment({
    Key? key,
    required this.selectedFilterAssignment,
  }) : super(key: key);

  final ValueNotifier<FilterAssignmentType> selectedFilterAssignment;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterCourses(
            onTap: () {
              selectedFilterAssignment.value = FilterAssignmentType.allUpcoming;
            },
            color: selectedFilterAssignment.value ==
                    FilterAssignmentType.thisWeek
                ? Palette.lighterGrey
                : selectedFilterAssignment.value == FilterAssignmentType.pastDue
                    ? Palette.lighterGrey
                    : Palette.purple,
            textColor: selectedFilterAssignment.value ==
                    FilterAssignmentType.thisWeek
                ? Palette.lightGrey
                : selectedFilterAssignment.value == FilterAssignmentType.pastDue
                    ? Palette.lightGrey
                    : Colors.white,
            label: 'All Upcoming',
          ),
          const SizedBox(
            width: 13,
          ),
          FilterCourses(
            onTap: () {
              selectedFilterAssignment.value = FilterAssignmentType.thisWeek;
            },
            color: selectedFilterAssignment.value ==
                    FilterAssignmentType.allUpcoming
                ? Palette.lighterGrey
                : selectedFilterAssignment.value == FilterAssignmentType.pastDue
                    ? Palette.lighterGrey
                    : Palette.purple,
            textColor: selectedFilterAssignment.value ==
                    FilterAssignmentType.allUpcoming
                ? Palette.lightGrey
                : selectedFilterAssignment.value == FilterAssignmentType.pastDue
                    ? Palette.lightGrey
                    : Colors.white,
            label: 'This Week',
          ),
          const SizedBox(
            width: 13,
          ),
          FilterCourses(
            onTap: () {
              selectedFilterAssignment.value = FilterAssignmentType.pastDue;
            },
            color: selectedFilterAssignment.value ==
                    FilterAssignmentType.allUpcoming
                ? Palette.lighterGrey
                : selectedFilterAssignment.value ==
                        FilterAssignmentType.thisWeek
                    ? Palette.lighterGrey
                    : Palette.purple,
            textColor:
                selectedFilterAssignment.value == FilterAssignmentType.thisWeek
                    ? Palette.lightGrey
                    : selectedFilterAssignment.value ==
                            FilterAssignmentType.allUpcoming
                        ? Palette.lightGrey
                        : Colors.white,
            label: 'Past Due',
          ),
        ],
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  const CourseList({
    Key? key,
    required this.selectedFilterValue,
  }) : super(key: key);

  final ValueNotifier<FilterCourseType> selectedFilterValue;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FilterCourseType>(
      valueListenable: selectedFilterValue,
      builder: (context, value, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabCourse(selectedFilterValue: selectedFilterValue),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(10, (index) => const CourseCard()),
            )
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Palette.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          'Business Innove RE16/DDD88/HD654/PDH99/BM676',
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: brytStyleJudul.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
                InkWell(onTap: () {}, child: const Icon(Icons.more_horiz))
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                height: 0,
                thickness: 2,
                color: Palette.secondary,
              ),
            ),
            Row(
              children: [
                Text(
                  'Zian Fahrudy Bolobolobolo',
                  style: brytStylegrey,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TabCourse extends StatelessWidget {
  const TabCourse({
    Key? key,
    required this.selectedFilterValue,
  }) : super(key: key);

  final ValueNotifier<FilterCourseType> selectedFilterValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterCourses(
            onTap: () {
              selectedFilterValue.value = FilterCourseType.inProgress;
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

class SegmentedCourse extends StatelessWidget {
  const SegmentedCourse({
    Key? key,
    required this.selectedValue,
  }) : super(key: key);

  final ValueNotifier<TabType> selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            },
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }
}

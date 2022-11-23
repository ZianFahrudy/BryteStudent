import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/widgets/filter_courses.dart';
import 'package:bryte/core/blocs/assignment/assignment_bloc.dart';
import 'package:bryte/core/data/model/course/request/course_body.dart';
import 'package:bryte/presentation/course/pages/course_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TabAssignment extends StatelessWidget {
  const TabAssignment({
    Key? key,
    required this.selectedFilterAssignment,
    required this.assignmentBloc,
  }) : super(key: key);

  final ValueNotifier<FilterAssignmentType> selectedFilterAssignment;
  final AssignmentBloc assignmentBloc;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Row(
          children: [
            FilterCourses(
              onTap: () {
                selectedFilterAssignment.value =
                    FilterAssignmentType.allUpcoming;
                assignmentBloc.add(GetCourseAssignment(
                  body: CourseBody(
                    token: token,
                    userid: userId,
                    type: 'upcoming',
                  ),
                ));
              },
              color: selectedFilterAssignment.value ==
                      FilterAssignmentType.thisWeek
                  ? Palette.lighterGrey
                  : selectedFilterAssignment.value ==
                          FilterAssignmentType.pastDue
                      ? Palette.lighterGrey
                      : Palette.purple,
              textColor: selectedFilterAssignment.value ==
                      FilterAssignmentType.thisWeek
                  ? Palette.lightGrey
                  : selectedFilterAssignment.value ==
                          FilterAssignmentType.pastDue
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
                assignmentBloc.add(GetCourseAssignment(
                  body: CourseBody(
                    token: token,
                    userid: userId,
                    type: 'weekly',
                  ),
                ));
              },
              color: selectedFilterAssignment.value ==
                      FilterAssignmentType.allUpcoming
                  ? Palette.lighterGrey
                  : selectedFilterAssignment.value ==
                          FilterAssignmentType.pastDue
                      ? Palette.lighterGrey
                      : Palette.purple,
              textColor: selectedFilterAssignment.value ==
                      FilterAssignmentType.allUpcoming
                  ? Palette.lightGrey
                  : selectedFilterAssignment.value ==
                          FilterAssignmentType.pastDue
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
                assignmentBloc.add(GetCourseAssignment(
                  body: CourseBody(
                    token: token,
                    userid: userId,
                    type: 'past',
                  ),
                ));
              },
              color: selectedFilterAssignment.value ==
                      FilterAssignmentType.allUpcoming
                  ? Palette.lighterGrey
                  : selectedFilterAssignment.value ==
                          FilterAssignmentType.thisWeek
                      ? Palette.lighterGrey
                      : Palette.purple,
              textColor: selectedFilterAssignment.value ==
                      FilterAssignmentType.thisWeek
                  ? Palette.lightGrey
                  : selectedFilterAssignment.value ==
                          FilterAssignmentType.allUpcoming
                      ? Palette.lightGrey
                      : Colors.white,
              label: 'Past Due',
            ),
          ],
        ),
      ),
    );
  }
}

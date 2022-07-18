import 'dart:developer';

import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/assignment/assignment_bloc.dart';
import 'package:bryte/core/data/model/course/response/course_model.dart';
import 'package:bryte/presentation/course/pages/detail_assignment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../components/utils/palette.dart';
import '../../local_widget/assignment_per_course_card.dart';

class AssignmentContent extends StatelessWidget {
  const AssignmentContent({
    Key? key,
    this.onTap,
    required this.bgColor,
    required this.dataCourse,
    required this.selectedSection,
  }) : super(key: key);

  final Function()? onTap;
  final String bgColor;
  final DataCourseModel dataCourse;
  final ValueNotifier<int> selectedSection;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssignmentBloc, AssignmentState>(
      listener: (context, state) {
        if (state is AssignmentPerCourseSuccess) {
          log('Assignment Per Course Success');
        } else if (state is AssignmentFailure) {
          log('Assignment Per Course Gagal');
        }
      },
      builder: (context, state) {
        if (state is AssignmentPerCourseSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Assignments',
                  style: BryteTypography.headerExtraBold,
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              if (state
                  .response.data[0].assignments[0].assignUpcomming.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Past Due',
                            style: BryteTypography.titleSemiBold,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '1',
                            style: BryteTypography.titleMedium
                                .copyWith(color: Palette.purple),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: state
                            .response.data[0].assignments[0].assignUpcomming
                            .map(
                              (data) => AssignmentPerCourseCard(
                                onTap: () => Get.to(
                                  () => DetailAssignmentPage(
                                    idAssign: data.idAssign,
                                    idCourse: dataCourse.idCourse,
                                    teacherName:
                                        state.response.data[0].teacherName,
                                    selectedSection: selectedSection,
                                    courseAssignName: data.assignName,
                                    bgColor: bgColor,
                                  ),
                                ),
                                assignDeadline: data.assignDeadline,
                                assignName: data.assignName,
                                assignStatus: data.assignStatus,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              if (state
                  .response.data[0].assignments[0].assignPastDue.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Past Due',
                            style: BryteTypography.titleSemiBold,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '1',
                            style: BryteTypography.titleMedium
                                .copyWith(color: Palette.purple),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            state.response.data[0].assignments[0].assignPastDue
                                .map(
                                  (data) => AssignmentPerCourseCard(
                                    onTap: () => Get.to(
                                      () => DetailAssignmentPage(
                                        idAssign: data.idAssign,
                                        idCourse: dataCourse.idCourse,
                                        teacherName:
                                            state.response.data[0].teacherName,
                                        selectedSection: selectedSection,
                                        courseAssignName: data.assignName,
                                        bgColor: bgColor,
                                      ),
                                    ),
                                    assignDeadline: data.assignDeadline,
                                    assignName: data.assignName,
                                    assignStatus: data.assignStatus,
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ),
            ],
          );
        } else if (state is AssignmentLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('Something Error'),
          );
        }
      },
    );
  }
}

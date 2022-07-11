import 'dart:developer';

import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/core/blocs/assignment/assignment_bloc.dart';
import 'package:bryte/core/data/model/course/response/assignment_model.dart';
import 'package:bryte/presentation/course/local_widget/course_assignment_card.dart';
import 'package:bryte/presentation/course/local_widget/tab_assignment.dart';
import 'package:bryte/presentation/course/pages/course_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignmentList extends StatefulWidget {
  const AssignmentList({
    Key? key,
    required this.selectedFilterAssignment,
    required this.assignmentBloc,
    required this.selectedSection,
  }) : super(key: key);

  final ValueNotifier<FilterAssignmentType> selectedFilterAssignment;
  final ValueNotifier<int> selectedSection;

  final AssignmentBloc assignmentBloc;

  @override
  State<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  var data = <DataAssignmentModel>[];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssignmentBloc, AssignmentState>(
      listener: (context, state) {
        if (state is AssignmentSuccess) {
          log('ASSIGNMENT SUCCESS');
          data = state.response.data;
        } else if (state is AssignmentFailure) {
          log('ASSIGNMENT GAGAL');
        }
      },
      builder: (context, state) {
        return ValueListenableBuilder<FilterAssignmentType>(
          valueListenable: widget.selectedFilterAssignment,
          builder: (context, value, _) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabAssignment(
                  selectedFilterAssignment: widget.selectedFilterAssignment,
                  assignmentBloc: widget.assignmentBloc,
                ),
                const SizedBox(height: 15),
                data.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: Image.asset(
                              AssetConstant.emptyCourseAssignmentWomen),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          data.length,
                          (index) => CardCourseAssignment(
                            selecteAssignSection: widget.selectedSection,
                            data: data[index],
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

import 'package:bryte/presentation/course/local_widget/course_assignment_card.dart';
import 'package:flutter/material.dart';

import '../../../core/data/model/course/response/assignment_model.dart';
import 'assigment_list.dart';

class AssignmentBryteList extends StatelessWidget {
  const AssignmentBryteList({
    Key? key,
    required this.data,
    required this.widget,
  }) : super(key: key);

  final List<DataAssignmentModel> data;
  final AssignmentList widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        data.length,
        (index) => Column(
          children: [
            CardCourseAssignment(
              selecteAssignSection: widget.selectedSection,
              data: data[index],
            ),
            if (index == data.length - 1)
              const SizedBox(
                height: 100,
              )
          ],
        ),
      ),
    );
  }
}

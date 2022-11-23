import 'package:bryte/components/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data/model/course/response/course_model.dart';
import '../pages/course_page.dart';
import '../pages/course_section_page.dart';
import 'course_card.dart';

class CourseBryteList extends StatelessWidget {
  const CourseBryteList({
    Key? key,
    required this.data,
    required this.selectedFilterValue,
  }) : super(key: key);

  final List<DataCourseModel> data;
  final ValueNotifier<FilterCourseType> selectedFilterValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        data.length,
        (index) => CourseCard(
          selectedFilterValue: selectedFilterValue,
          onTap: () => Get.to(
            () => SectionGeneralPage(
              dataCourse: data[index],
            ),
          ),
          shadowColor: HexColor(data[index].dropShadow),
          name: data[index].teacherName,
          title: data[index].course,
          color: HexColor(data[index].bgColor_1),
        ),
      ),
    );
  }
}

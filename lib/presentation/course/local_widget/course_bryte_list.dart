import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data/model/course/response/course_model.dart';
import '../pages/course_section_page.dart';
import 'course_card.dart';

class CourseBryteList extends StatelessWidget {
  const CourseBryteList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<DataCourseModel> data;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

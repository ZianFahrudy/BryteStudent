import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';

import '../local_widget/dropdown_semester.dart';

class AllScorePage extends StatelessWidget {
  const AllScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonAppBar(),
        title: Image.asset(AssetConstant.bryteLogoWhite),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.zero,
                      shadowColor: Palette.lightPurple,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          15,
                          10,
                          55,
                          10,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width / 2 - 105,
                                child: Text(
                                  'Cumulative GPA',
                                  style: BryteTypography.headerSemiBold
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              Text(
                                '3.98',
                                style: BryteTypography.headerExtraBold.copyWith(
                                  fontSize: 48,
                                  color: Palette.purple,
                                ),
                              )
                            ]),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      shadowColor: Palette.lightPurple,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 55, 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width / 2 - 105,
                                child: Text(
                                  'Total Credits Taken',
                                  style: BryteTypography.headerSemiBold
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              Text(
                                '119',
                                style: BryteTypography.headerExtraBold.copyWith(
                                  fontSize: 48,
                                  color: Palette.purple,
                                ),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            const DropdownSemester(),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: List.generate(
                semesters.length,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Semester ' +
                                    semesters[index].numberSemester.toString(),
                                style: BryteTypography.titleSemiBold,
                              ),
                              Text(
                                ' • ' +
                                    semesters[index].credits.toString() +
                                    ' credits',
                                style: BryteTypography.titleSemiBold
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            semesters[index].grade,
                            style: BryteTypography.titleSemiBold
                                .copyWith(color: Palette.purple),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 20, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            semesters[index].courseSemesters.length,
                            (i) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(semesters[index]
                                          .courseSemesters[i]
                                          .name),
                                    ),
                                    Text(
                                      semesters[index].courseSemesters[i].grade,
                                      style: BryteTypography.titleSemiBold,
                                    ),
                                  ],
                                )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<SemesterModel> semesters = [
  SemesterModel(
    numberSemester: 7,
    credits: 14,
    courseSemesters: courseSemesters,
    grade: '3.40',
  ),
  SemesterModel(
    numberSemester: 6,
    credits: 20,
    courseSemesters: courseSemesters,
    grade: '3.50',
  ),
  SemesterModel(
    numberSemester: 5,
    credits: 18,
    courseSemesters: courseSemesters,
    grade: '3.81',
  ),
  SemesterModel(
    numberSemester: 4,
    credits: 31,
    courseSemesters: courseSemesters,
    grade: '3.90',
  ),
];

class SemesterModel {
  final int numberSemester;
  final int credits;
  final List<CourseScoreModel> courseSemesters;
  final String grade;
  SemesterModel({
    required this.numberSemester,
    required this.credits,
    required this.courseSemesters,
    required this.grade,
  });
}

class CourseScoreModel {
  final String name;
  final int sks;
  final String grade;

  CourseScoreModel({
    required this.name,
    required this.sks,
    required this.grade,
  });
}

List<CourseScoreModel> courseSemesters = [
  CourseScoreModel(
    name: 'Computer Aided Engineering',
    sks: 3,
    grade: 'A',
  ),
  CourseScoreModel(
    name: 'Design for Meaning',
    sks: 4,
    grade: 'AB',
  ),
  CourseScoreModel(
    name: 'Design for Manufacturing',
    sks: 2,
    grade: 'B',
  ),
];

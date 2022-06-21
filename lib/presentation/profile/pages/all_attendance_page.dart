import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/components/widgets/back_button.dart';
import 'package:bryte/presentation/course/pages/all_scores_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class AllAttendancePage extends StatelessWidget {
  const AllAttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonAppBar(),
        centerTitle: true,
        title: Text(
          'All Attendace',
          style: BryteTypography.titleSemiBold
              .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(20),
              shadowColor: Palette.lightPurple,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        'Current Attendance Rate',
                        style: BryteTypography.headerSemiBold
                            .copyWith(fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '90%',
                      style: BryteTypography.headerExtraBold.copyWith(
                        fontSize: 48,
                        color: Palette.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const DropdownSemester(),
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
    );
  }
}

import 'dart:developer';

import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/widgets/back_button.dart';
import 'package:bryte/core/blocs/gpa_grade/gpa_grade_bloc.dart';
import 'package:bryte/core/data/model/profile/response/gpa_grade_model.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/data/model/profile/request/gpa_grade_body.dart';
import '../../profile/local_widgets/dropdown_score_semester.dart';

class AllScorePage extends StatefulWidget {
  const AllScorePage({
    Key? key,
    required this.gpaGradeBloc,
  }) : super(key: key);

  final GpaGradeBloc gpaGradeBloc;

  @override
  State<AllScorePage> createState() => _AllScorePageState();
}

class _AllScorePageState extends State<AllScorePage> {
  final selectedValue = ValueNotifier<String>('0');

  List<DataGpaGradeModel> dataGradeList = [];

  double cumulativeGpa = 0;
  int totalCredits = 0;

  final gpaGradeBloc = getIt<GpaGradeBloc>();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);

    return BlocProvider(
      create: (context) => gpaGradeBloc
        ..add(GetGpaGradeEvent(
            body: GpaGradeBody(
          token: token,
          userid: userId,
          semester: selectedValue.value,
        ))),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButtonAppBar(),
          title: Image.asset(
            AssetConstant.bryteLogoWhite,
            width: 59,
          ),
          centerTitle: true,
        ),
        body: BlocListener<GpaGradeBloc, GpaGradeState>(
          listener: (context, state) {
            if (state is GpaGradeSuccess) {
              log('gpa grade success');
              dataGradeList = state.response.data;
              cumulativeGpa = state.response.data[0].finalGpa;
              totalCredits = state.response.data[0].totSks;

              setState(() {});
              log(cumulativeGpa.toString());
            } else if (state is GpaGradeFailure) {
              log('gpa grade gagal');
            }
          },
          child: ValueListenableBuilder(
            valueListenable: selectedValue,
            builder: (context, value, __) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderCard(),
                  const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownScoreSemester(
                    selectedValue: selectedValue,
                    gradeBloc: gpaGradeBloc,
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (value != '' && dataGradeList.isNotEmpty)
                    _buildFinalGradeList()
                  else
                    const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
                        style: BryteTypography.headerSemiBold.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      cumulativeGpa.toString(),
                      style: BryteTypography.headerExtraBold.copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                      style:
                          BryteTypography.headerSemiBold.copyWith(fontSize: 15),
                    ),
                  ),
                  Text(
                    totalCredits.toString(),
                    style: BryteTypography.headerExtraBold.copyWith(
                      fontSize: 48,
                      color: Palette.purple,
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

  Widget _buildFinalGradeList() {
    return Column(
      children: List.generate(
        dataGradeList[0].finalGrade.length,
        (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Semester ' +
                            dataGradeList[0]
                                .finalGrade[index]
                                .semester
                                .toString(),
                        style: BryteTypography.titleSemiBold,
                      ),
                      // Text(
                      //   ' • ' +
                      //       'dataGradeList[0].finalGrade[index].sks.toString()' +
                      //       ' credits',
                      //   style: BryteTypography.titleSemiBold
                      //       .copyWith(fontWeight: FontWeight.normal),
                      // ),
                    ],
                  ),
                  Text(
                    dataGradeList[0].finalGpa.toString(),
                    style: BryteTypography.titleSemiBold.copyWith(
                      color: Palette.purple,
                    ),
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: List.generate(
                dataGradeList[0].finalGrade[index].grade.length,
                (ind) => Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${dataGradeList[0].finalGrade[index].grade[ind].course} • ${dataGradeList[0].finalGrade[index].grade[ind].sks}',
                        style: BryteTypography.titleMedium.copyWith(
                            color: const Color(
                              0xffA2A2A2,
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(
                        dataGradeList[0].finalGrade[index].grade[ind].grade,
                        style: BryteTypography.titleSemiBold.copyWith(
                            color: const Color(0xffA2A2A2),
                            fontWeight: FontWeight.w800,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'dataGradeList[0].finalGrade[index].course',
            //         style: BryteTypography.titleMedium.copyWith(
            //             color: const Color(
            //               0xffA2A2A2,
            //             ),
            //             fontWeight: FontWeight.w500,
            //             fontSize: 15),
            //       ),
            //       Text(
            //         'dataGradeList[0].finalGrade[index].grade',
            //         style: BryteTypography.titleSemiBold.copyWith(
            //             color: const Color(0xffA2A2A2),
            //             fontWeight: FontWeight.w800,
            //             fontSize: 15),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}

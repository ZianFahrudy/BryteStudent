import 'package:bryte/core/blocs/gpa_grade/gpa_grade_bloc.dart';
import 'package:bryte/core/blocs/score/score_bloc.dart';
import 'package:bryte/core/data/model/course/response/score_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../components/utils/palette.dart';
import '../../../../components/utils/typography.dart';
import '../all_scores_page.dart';

class ScoreContent extends StatelessWidget {
  const ScoreContent({
    Key? key,
    required this.gpaGradeBloc,
    required this.idCourse,
  }) : super(key: key);

  final GpaGradeBloc gpaGradeBloc;
  final String idCourse;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScoreBloc, ScoreState>(
      listener: (context, state) {
        if (state is ScoreSuccess) {
        } else if (state is ScoreFailure) {}
      },
      builder: (context, state) {
        if (state is ScoreSuccess) {
          return _buildScoreSuccess(state.response);
        } else if (state is ScoreLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Column _buildScoreSuccess(ScoreModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Scores',
                style: BryteTypography.headerExtraBold
                    .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              InkWell(
                onTap: () => Get.to(
                  () => AllScorePage(
                    gpaGradeBloc: gpaGradeBloc,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'All Scores',
                      style: BryteTypography.titleSemiBold.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Palette.purple,
                          fontSize: 11),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 15,
                      color: Palette.purple,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            thickness: 1,
            height: 0,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Palette.lightPurple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Final Grade',
                    style:
                        BryteTypography.headerSemiBold.copyWith(fontSize: 18),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.info_outline,
                    size: 18,
                    color: Palette.grey,
                  )
                ],
              ),
              Text(
                data.data[0].studentScore.isNotEmpty
                    ? data.data[0].studentScore[0].finalGrade
                    : '-',
                style: BryteTypography.headerExtraBold.copyWith(
                  fontSize: 70,
                  color: Palette.purple,
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            height: 0,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Teaching',
                        style: BryteTypography.headerSemiBold
                            .copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          'Assessment',
                          style: BryteTypography.headerSemiBold
                              .copyWith(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.data[0].studentScore.isNotEmpty
                          ? data.data[0].studentScore[0].teachingAssessment
                              .toString()
                          : '-',
                      style: BryteTypography.headerExtraBold.copyWith(
                        fontSize: 70,
                        fontWeight: FontWeight.w500,
                        color: Palette.purple,
                      ),
                    ),
                    // Text(
                    //   'Weight 30%',
                    //   style: BryteTypography.titleMedium
                    //       .copyWith(fontStyle: FontStyle.italic),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: VerticalDivider(
                    thickness: 1,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Mid-Semester',
                        style: BryteTypography.headerSemiBold
                            .copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          'Exam',
                          style: BryteTypography.headerSemiBold
                              .copyWith(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.data[0].studentScore.isNotEmpty
                          ? data.data[0].studentScore[0].midSemMarks.toString()
                          : '-',
                      style: BryteTypography.headerExtraBold.copyWith(
                        fontSize: 70,
                        fontWeight: FontWeight.w500,
                        color: Palette.purple,
                      ),
                    ),
                    // Text(
                    //   'Weight 35%',
                    //   style: BryteTypography.titleMedium
                    //       .copyWith(fontStyle: FontStyle.italic),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            height: 0,
            thickness: 1,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Mid-Semester',
              style: BryteTypography.headerSemiBold.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.data[0].studentScore.isNotEmpty
                    ? data.data[0].studentScore[0].endSemMarks.toString()
                    : '-',
                style: BryteTypography.headerExtraBold.copyWith(
                  fontSize: 70,
                  fontWeight: FontWeight.w500,
                  color: Palette.purple,
                ),
              ),
              // Text(
              //   'Weight 35%',
              //   style: BryteTypography.titleMedium
              //       .copyWith(fontStyle: FontStyle.italic),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';
import '../../../core/blocs/gpa_grade/gpa_grade_bloc.dart';
import '../../course/pages/all_scores_page.dart';

class CumulativeCard extends StatelessWidget {
  const CumulativeCard({
    Key? key,
    required this.gpaGradeBloc,
    required this.gpaScore,
    required this.totalSks,
    required this.cumulativeGpa,
  }) : super(key: key);

  final GpaGradeBloc gpaGradeBloc;
  final double gpaScore;
  final String totalSks;
  final double cumulativeGpa;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      shadowColor: Palette.lightPurple,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    'Cumulative GPA',
                    style: BryteTypography.headerSemiBold.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  gpaScore.toString(),
                  style: BryteTypography.headerExtraBold.copyWith(
                    fontSize: 48,
                    color: Palette.purple,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                              fontWeight: FontWeight.bold,
                              color: Palette.purple,
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: Palette.purple,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CircularStepProgressIndicator(
              totalSteps: 4,
              currentStep: cumulativeGpa.round(),
              stepSize: 10,
              selectedColor: Palette.purple,
              unselectedColor: Colors.grey[200],
              padding: 0,
              width: 100,
              height: 100,
              selectedStepSize: 15,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      gpaScore.toString(),
                      style: BryteTypography.titleExtraBold
                          .copyWith(color: Palette.purple),
                    ),
                    Text(
                      '/4.00',
                      style: BryteTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Palette.grey1,
                      ),
                    ),
                  ],
                ),
              ),
              roundedCap: (_, __) => true,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bryte/presentation/course/pages/all_attendance_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';

class AttendanceRateCard extends StatelessWidget {
  const AttendanceRateCard({
    Key? key,
    required this.currentAtt,
  }) : super(key: key);

  final String currentAtt;

  @override
  Widget build(BuildContext context) {
    final currentStepString = currentAtt.replaceFirst(' %', '');

    final currentStep = double.tryParse(
      currentStepString,
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
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
                    'Current\nAttendance Rate',
                    style:
                        BryteTypography.headerSemiBold.copyWith(fontSize: 15),
                  ),
                ),
                Text(
                  currentAtt,
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
                      onTap: () => Get.to(() => const AllAttendancePage()),
                      child: Row(
                        children: [
                          Text(
                            'All Attendance',
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
              totalSteps: 100,
              currentStep: currentStep == null ? 0 : currentStep.toInt(),
              stepSize: 10,
              unselectedStepSize: 10,
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
                      currentAtt.replaceFirst('%', ''),
                      style: BryteTypography.titleExtraBold
                          .copyWith(color: Palette.purple),
                    ),
                    Text(
                      '/100',
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

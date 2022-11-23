import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';

class CurrentAttendanceRate extends StatelessWidget {
  const CurrentAttendanceRate({
    Key? key,
    required this.currentAttd,
  }) : super(key: key);

  final String currentAttd;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(20),
        shadowColor: Palette.lightPurple,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  'Current Attendance Rate',
                  style: BryteTypography.headerSemiBold
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                currentAttd,
                style: BryteTypography.headerExtraBold.copyWith(
                    fontSize: 48,
                    color: Palette.purple,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

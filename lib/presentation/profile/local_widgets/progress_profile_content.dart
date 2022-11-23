// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';
import '../../../components/widgets/linear_proggress_indicator.dart';

class ProggresProfileContent extends StatelessWidget {
  const ProggresProfileContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            shadowColor: Palette.purple,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Level 2',
                    style: BryteTypography.headerExtraBold.copyWith(
                        color: const Color(0xffFF9458),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 20.0,
                    leading: const Text("left content"),
                    trailing: const Text("right content"),
                    percent: 0.9,
                    center: const Text("20.0%"),
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

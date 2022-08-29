import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/utils/palette.dart';
import '../../../../components/utils/typography.dart';
import '../all_scores_page.dart';

class ScoreContent extends StatelessWidget {
  const ScoreContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Scores',
                style: BryteTypography.headerExtraBold,
              ),
              InkWell(
                onTap: () => Get.to(
                  () => const AllScorePage(),
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
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
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
                'A',
                style: BryteTypography.headerExtraBold.copyWith(
                  fontSize: 70,
                  color: Palette.purple,
                ),
              )
            ],
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
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
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.info_outline,
                          size: 18,
                          color: Palette.grey,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '88',
                      style: BryteTypography.headerExtraBold.copyWith(
                        fontSize: 70,
                        fontWeight: FontWeight.w500,
                        color: Palette.purple,
                      ),
                    ),
                    Text(
                      'Weight 30%',
                      style: BryteTypography.titleMedium
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: VerticalDivider(
                    thickness: 2,
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
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.info_outline,
                          size: 18,
                          color: Palette.grey,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '91',
                      style: BryteTypography.headerExtraBold.copyWith(
                        fontSize: 70,
                        fontWeight: FontWeight.w500,
                        color: Palette.purple,
                      ),
                    ),
                    Text(
                      'Weight 35%',
                      style: BryteTypography.titleMedium
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
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
            const SizedBox(width: 5),
            const Icon(
              Icons.info_outline,
              size: 18,
              color: Palette.grey,
            ),
          ],
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '100',
                style: BryteTypography.headerExtraBold.copyWith(
                  fontSize: 70,
                  fontWeight: FontWeight.w500,
                  color: Palette.purple,
                ),
              ),
              Text(
                'Weight 35%',
                style: BryteTypography.titleMedium
                    .copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
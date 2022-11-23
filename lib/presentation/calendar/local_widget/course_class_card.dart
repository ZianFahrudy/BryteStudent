import 'package:bryte/components/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';
import '../../../core/data/model/calendar/response/event_model.dart';

class CourseClassCard extends StatelessWidget {
  const CourseClassCard({
    Key? key,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.event,
    required this.attdStatus,
  }) : super(key: key);

  final String date;
  final String startTime;
  final String endTime;
  final Event event;
  final String attdStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: HexColor(event.bgColor1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.school,
                              size: 15,
                              color: Palette.neutral300,
                            ),
                            const SizedBox(width: 5),
                            Text(ReCase(event.type).constantCase,
                                style: BryteTypography.bodyRegular.copyWith(
                                  color: Palette.neutral300,
                                )),
                          ],
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                            width: Get.width - 210,
                            child: Text(
                              event.classes!,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: BryteTypography.headerExtraBold.copyWith(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(.6)),
                            )),
                        const SizedBox(height: 4),
                        Text(
                          '$date • $startTime - $endTime',
                          style: BryteTypography.bodyMedium
                              .copyWith(color: Palette.purple),
                        )
                      ],
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
                const Spacer(),
                if (!(attdStatus == 'W'))
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                        color: HexColor(event.bgColor1).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      attdStatus == 'P'
                          ? 'PRESENT'
                          : attdStatus == 'L'
                              ? 'LATE'
                              : attdStatus == 'A'
                                  ? 'ABSENT'
                                  : attdStatus == 'W'
                                      ? 'WAITING'
                                      : 'EXCUSED',
                      style: BryteTypography.button
                          .copyWith(color: HexColor(event.bgColor1)),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

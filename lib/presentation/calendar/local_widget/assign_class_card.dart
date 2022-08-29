import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/theme.dart';
import '../../../components/utils/typography.dart';
import '../../../core/data/model/calendar/response/event_model.dart';

class AssignClassCard extends StatelessWidget {
  const AssignClassCard({
    Key? key,
    required this.value,
  }) : super(key: key);

  final Event value;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Palette.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  DateFormat('dd MMM')
                      .format(DateTime.parse(value.assignDeadline!)),
                  style: brytStyleJudul.copyWith(
                    fontSize: 14,
                    color: Palette.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  DateFormat('HH:mm')
                      .format(DateTime.parse(value.assignDeadline!)),
                  style: brytStyleJudul.copyWith(
                    fontSize: 16,
                    color: Palette.purple,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Container(
              width: 2,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              color: Palette.secondary,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.assignment,
                      size: 15,
                      color: Palette.neutral300,
                    ),
                    const SizedBox(width: 5),
                    Text(ReCase(value.type).constantCase,
                        style: BryteTypography.bodyRegular.copyWith(
                          color: Palette.neutral300,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: Get.width - 260,
                  child: Text(
                    value.assignName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: BryteTypography.headerExtraBold.copyWith(
                        fontSize: 16, color: Colors.black.withOpacity(.6)),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      height: 11,
                      width: 11,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Palette.sunkist400),
                    ),
                    SizedBox(
                      width: Get.width - 300,
                      child: Text(
                        value.assignDescp!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: brytStyleJudul.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Palette.lightGrey),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                value.assignAttempt! ? 'SUBMITTED' : 'NOT ATTEMPTED',
                style: BryteTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        value.assignAttempt! ? Palette.sprite500 : Palette.red),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:
                    value.assignAttempt! ? Palette.sprite200 : Palette.coke200,
              ),
            )
          ],
        ),
      ),
    );
  }
}

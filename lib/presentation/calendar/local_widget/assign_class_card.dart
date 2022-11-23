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
    final dateTimeNow = DateFormat('dd MMMM').format(DateTime.now());
    final compareDueDate =
        DateFormat('dd MMMM').format(DateTime.parse(value.assignDeadline!));
    final dueDate =
        DateFormat('dd MMM').format(DateTime.parse(value.assignDeadline!));

    final now = DateTime.now();

    final tomorrow =
        DateFormat('dd MMMM').format(now.subtract(const Duration(days: 1)));

    final timeDeadline =
        DateFormat('HH:mm').format(DateTime.parse(value.assignDeadline!));

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
                  dateTimeNow == compareDueDate
                      ? 'Today'
                      : tomorrow == compareDueDate
                          ? 'Tomorrow'
                          : dueDate,
                  style: brytStyleJudul.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: dateTimeNow == compareDueDate
                          ? const Color(0xffFF5858)
                          : tomorrow == compareDueDate
                              ? Palette.purple
                              : Palette.purple),
                ),
                Text(timeDeadline,
                    style: brytStyleJudul.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: dateTimeNow == compareDueDate
                            ? const Color(0xffFF5858)
                            : tomorrow == compareDueDate
                                ? Palette.purple
                                : Palette.purple)),
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
                      color: Palette.darkPurple,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      ReCase(value.type).constantCase,
                      style: BryteTypography.bodyRegular.copyWith(
                          color: Palette.darkPurple,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
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
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: const Color(0xff000000).withOpacity(.6),
                    ),
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
                      width: Get.width - 275,
                      child: Text(
                        value.assignDescp!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: brytStyleJudul.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff969696)),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Container(
              width: 99,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                value.assignAttempt! ? 'SUBMITTED' : 'NOT ATTEMPTED',
                style: BryteTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                    color: value.assignAttempt!
                        ? Palette.sprite500
                        : value.assignAttempt == false &&
                                dateTimeNow == compareDueDate
                            ? Palette.red
                            : const Color(0xffA2A2A2)),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: value.assignAttempt!
                    ? Palette.sprite200
                    : value.assignAttempt == false &&
                            dateTimeNow == compareDueDate
                        ? Palette.coke200
                        : const Color(0xffE7E7E7),
              ),
            )
          ],
        ),
      ),
    );
  }
}

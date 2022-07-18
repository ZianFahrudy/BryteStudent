import 'package:bryte/components/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/utils/palette.dart';
import 'course_assignment_card.dart';

class AssignmentPerCourseCard extends StatelessWidget {
  const AssignmentPerCourseCard({
    Key? key,
    required this.onTap,
    required this.assignName,
    required this.assignStatus,
    required this.assignDeadline,
  }) : super(key: key);

  final Function()? onTap;
  final String assignName;
  final String assignStatus;
  final String assignDeadline;

  @override
  Widget build(BuildContext context) {
    final dateTimeNow = DateFormat('dd MMMM').format(DateTime.now());
    final compareDueDate =
        DateFormat('dd MMMM').format(DateTime.parse(assignDeadline));
    final dueDate = DateFormat('dd MMM').format(DateTime.parse(assignDeadline));

    final now = DateTime.now();

    final tomorrow =
        DateFormat('dd MMMM').format(now.subtract(const Duration(days: 1)));

    final timeDeadline =
        DateFormat('HH:mm').format(DateTime.parse(assignDeadline));
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: IntrinsicHeight(
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
                      style: BryteTypography.bodyRegular.copyWith(
                          color: Palette.purple, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      timeDeadline,
                      style: BryteTypography.titleSemiBold.copyWith(
                        color: Palette.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(
                  thickness: 2,
                  width: 20,
                  color: Palette.lightPurple,
                ),
                Expanded(
                  child: Text(
                    assignName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: BryteTypography.titleMedium,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Palette.red.withOpacity(0.05),
                  ),
                  child: Text(
                    assignStatus == AssignStatus.submitted
                        ? 'SUBMITTED'
                        : assignStatus == AssignStatus.notAttempted
                            ? 'NOT ATTEMPTED'
                            : 'LATE',
                    style: BryteTypography.bodyMedium.copyWith(
                        color: assignStatus == AssignStatus.submitted
                            ? Palette.sprite500
                            : assignStatus == AssignStatus.notAttempted
                                ? Palette.red
                                : Palette.sunkist500),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

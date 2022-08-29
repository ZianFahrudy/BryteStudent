import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';

class LabelAssignment extends StatelessWidget {
  const LabelAssignment({
    Key? key,
    required this.label,
    required this.description,
  }) : super(key: key);

  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Palette.lightPurple,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                label,
                style: BryteTypography.titleSemiBold
                    .copyWith(color: Palette.purple),
              ),
            ),
            const SizedBox(
              height: 40,
              child: VerticalDivider(
                width: 0,
                thickness: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Text(
                description,
                style: BryteTypography.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

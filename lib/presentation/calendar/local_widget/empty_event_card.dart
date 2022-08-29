import 'package:flutter/material.dart';

import '../../../components/utils/constant.dart';
import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';

class EmptyEventCard extends StatelessWidget {
  const EmptyEventCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
          color: Palette.primary100, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Image.asset(AssetConstant.emptyZzz),
          const SizedBox(width: 16),
          Text(
            'No classes, no assignments, nothing!',
            style: BryteTypography.bodyMedium.copyWith(
                color: Palette.headerSpecial,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          )
        ],
      ),
    );
  }
}

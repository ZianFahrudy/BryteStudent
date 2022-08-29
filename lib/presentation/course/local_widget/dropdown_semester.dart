import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';

class DropdownSemester extends StatelessWidget {
  const DropdownSemester({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Palette.purple1, borderRadius: BorderRadius.circular(48)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'All Semesters',
            style: BryteTypography.titleSemiBold
                .copyWith(color: Palette.darkPurple),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 30,
              child: VerticalDivider(
                width: 0,
                thickness: 1,
                color: Colors.white,
              ),
            ),
          ),
          const Icon(
            Icons.expand_more,
            size: 20,
            color: Palette.darkPurple,
          )
        ],
      ),
    );
  }
}

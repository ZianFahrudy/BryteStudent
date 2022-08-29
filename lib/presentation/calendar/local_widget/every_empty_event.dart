import 'package:flutter/material.dart';

import '../../../components/utils/constant.dart';
import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';

class EveryEmptyEvent extends StatelessWidget {
  const EveryEmptyEvent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetConstant.emptyCalendar),
          const SizedBox(
            height: 17,
          ),
          Text(
            'Apparently you are free..',
            style: BryteTypography.headerExtraBold
                .copyWith(color: Palette.darkPurple),
          ),
          const SizedBox(height: 6),
          const Text(
            'Enjoy your free time, while it lasts ;)',
            style: BryteTypography.titleMedium,
          )
        ],
      ),
    );
  }
}

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/theme.dart';
import '../pages/calendar_page.dart';

class SegmentedCalendar extends StatelessWidget {
  const SegmentedCalendar({
    Key? key,
    required this.selectedValue,
  }) : super(key: key);

  final ValueNotifier<TabCalendarType> selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Palette.primary100,
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: CustomSlidingSegmentedControl<TabCalendarType>(
              height: 30,
              innerPadding: const EdgeInsets.all(0),
              children: {
                TabCalendarType.weekly: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Weekly',
                    style: brytStylebtn.copyWith(
                        color: selectedValue.value == TabCalendarType.monthly
                            ? Palette.headerSpecial
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                TabCalendarType.monthly: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Monthly',
                    style: brytStylebtn.copyWith(
                        color: selectedValue.value == TabCalendarType.weekly
                            ? Palette.darkPurple
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              },
              decoration: BoxDecoration(
                color: Palette.secondary100,
                borderRadius: BorderRadius.circular(27),
              ),
              thumbDecoration: BoxDecoration(
                color: Palette.headerSpecial,
                borderRadius: BorderRadius.circular(27),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(
                      0.0,
                      2.0,
                    ),
                  ),
                ],
              ),
              onValueChanged: (TabCalendarType value) {
                selectedValue.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}

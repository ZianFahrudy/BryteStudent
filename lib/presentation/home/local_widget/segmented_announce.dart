import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/theme.dart';

enum TabAnnounceType { notif, announce }

class SegmentedAnnouncement extends StatelessWidget {
  const SegmentedAnnouncement({Key? key, required this.selectedValue})
      : super(key: key);

  final ValueNotifier<TabAnnounceType> selectedValue;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedValue,
      builder: (context, _, __) => Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CustomSlidingSegmentedControl<TabAnnounceType>(
                height: 30,
                initialValue: TabAnnounceType.announce,
                innerPadding: const EdgeInsets.all(0),
                children: {
                  TabAnnounceType.notif: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Notifications',
                      style: brytStylebtn.copyWith(
                          color: selectedValue.value == TabAnnounceType.announce
                              ? Palette.headerSpecial
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TabAnnounceType.announce: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Announcements',
                      style: brytStylebtn.copyWith(
                          color: selectedValue.value == TabAnnounceType.notif
                              ? Palette.darkPurple
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                },
                decoration: BoxDecoration(
                  color: Palette.secondary,
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
                onValueChanged: (TabAnnounceType value) {
                  selectedValue.value = value;
                },
              )),
          const Divider(
            thickness: 1,
            height: 0,
          ),
        ],
      ),
    );
  }
}

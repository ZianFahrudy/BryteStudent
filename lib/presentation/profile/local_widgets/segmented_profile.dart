import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/theme.dart';

enum ProfileTabType { proggress, academic, personal }

class SegmentedProfile extends StatelessWidget {
  const SegmentedProfile({
    Key? key,
    required this.selectedValue,
  }) : super(key: key);

  final ValueNotifier<ProfileTabType> selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: CustomSlidingSegmentedControl<ProfileTabType>(
            height: 30,
            innerPadding: const EdgeInsets.all(0),
            children: {
              // ProfileTabType.proggress: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Text(
              //     'Proggress',
              //     style: brytStylebtn.copyWith(
              //         color: selectedValue.value != ProfileTabType.proggress
              //             ? Palette.headerSpecial
              //             : Colors.white,
              //         fontWeight: FontWeight.w500,
              //         fontSize: 16),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              ProfileTabType.academic: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Academic',
                  style: brytStylebtn.copyWith(
                      color: selectedValue.value != ProfileTabType.academic
                          ? Palette.darkPurple
                          : Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              ProfileTabType.personal: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Personal',
                  style: brytStylebtn.copyWith(
                      color: selectedValue.value != ProfileTabType.personal
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
            onValueChanged: (ProfileTabType value) {
              selectedValue.value = value;
            },
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }
}
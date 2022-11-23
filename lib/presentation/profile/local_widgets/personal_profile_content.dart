import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';
import '../../../core/blocs/profile/profile_bloc.dart';

class PersonalProfileContent extends StatelessWidget {
  const PersonalProfileContent({
    Key? key,
    required this.state,
  }) : super(key: key);

  final ProfileSuccess state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'NAME',
            style: BryteTypography.titleMedium.copyWith(
                color: Palette.lightGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
          const SizedBox(height: 5),
          Text(
            state.response.users[0].fullname!
                .replaceAll(RegExp('[^A-Za-z ]'), '')
                .trim(),
            style: BryteTypography.titleSemiBold.copyWith(
                color: const Color(0xff666666),
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
          const SizedBox(height: 10),
          Text(
            'EMAIL',
            style: BryteTypography.titleMedium.copyWith(
                color: Palette.lightGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
          const SizedBox(height: 5),
          Text(
            state.response.users[0].email!,
            style: BryteTypography.titleSemiBold.copyWith(
                color: const Color(0xff666666),
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
          const SizedBox(height: 10),
          Text(
            'STUDENT NUMBER (NIM)',
            style: BryteTypography.titleMedium.copyWith(
                color: Palette.lightGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
          const SizedBox(height: 5),
          Text(
            state.response.users[0].fullname!.split(' ').first,
            style: BryteTypography.titleSemiBold.copyWith(
                color: const Color(0xff666666),
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
          const SizedBox(height: 10),
          Text(
            'PROGRAM',
            style: BryteTypography.titleMedium.copyWith(
                color: Palette.lightGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
          const SizedBox(height: 5),
          Text(
            state.response.users[0].department!,
            style: BryteTypography.titleSemiBold.copyWith(
              color: const Color(0xff666666),
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
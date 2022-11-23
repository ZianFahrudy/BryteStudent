import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/presentation/profile/local_widgets/personal_profile_content.dart';
import 'package:bryte/presentation/profile/local_widgets/profile_student.dart';
import 'package:bryte/presentation/profile/local_widgets/segmented_profile.dart';
import 'package:flutter/material.dart';

import '../../../components/utils/typography.dart';
import '../../../core/blocs/gpa_grade/gpa_grade_bloc.dart';
import '../../../core/blocs/profile/profile_bloc.dart';
import 'attendance_rate_card.dart';
import 'cumulative_card.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    Key? key,
    required this.selectedTab,
    required this.gpaGradeBloc,
    required this.gpaScore,
    required this.totalSks,
    required this.currentAttd,
    required this.state,
  }) : super(key: key);

  final ValueNotifier<ProfileTabType> selectedTab;
  final GpaGradeBloc gpaGradeBloc;
  final double gpaScore;
  final String totalSks;
  final List<String> currentAttd;
  final ProfileSuccess state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder<ProfileTabType>(
        valueListenable: selectedTab,
        builder: (context, v, c) => Column(children: [
          const SizedBox(height: 20),
          ProfileStudent(
            imageUrl: state.response.users[0].profileimageurl!,
          ),
          const SizedBox(height: 20),
          Text(
            state.response.users[0].fullname!
                .replaceAll(RegExp('[^A-Z ]'), '')
                .trim(),
            style: BryteTypography.titleExtraBold.copyWith(
              color: Palette.darkPurple,
            ),
          ),
          const SizedBox(height: 10),
          Text(state.response.users[0].department!),
          const SizedBox(height: 20),
          SegmentedProfile(
            selectedValue: selectedTab,
          ),
          if (v == ProfileTabType.academic)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CumulativeCard(
                  gpaGradeBloc: gpaGradeBloc,
                  gpaScore: gpaScore,
                  totalSks: totalSks,
                  cumulativeGpa: gpaScore,
                ),
                AttendanceRateCard(
                  currentAtt: currentAttd.isEmpty ? '' : currentAttd.first,
                ),
              ],
            )
          else if (v == ProfileTabType.personal)
            PersonalProfileContent(
              state: state,
            )
          else
            Container()
        ]),
      ),
    );
  }
}

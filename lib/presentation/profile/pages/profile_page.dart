import 'dart:developer';

import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/profile/profile_bloc.dart';
import 'package:bryte/core/data/model/profile/request/profile_body.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/auth/pages/signin.dart';
import 'package:bryte/presentation/course/pages/all_scores_page.dart';
import 'package:bryte/presentation/profile/pages/all_attendance_page.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../local_widgets/profile_student.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final selectedTab = ValueNotifier(ProfileTabType.proggress);

    final profileBloc = getIt<ProfileBloc>();

    return BlocProvider(
      create: (context) => profileBloc
        ..add(GetUserProfileEvent(
            body: ProfileBody(
                wstoken: 'c66dcf796b6cf10d0971da5b7c027847',
                wsfunction: 'core_user_get_users',
                moodlewsrestformat: 'json',
                criteriaid: 'id',
                criteriauserid: 15543))),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(AssetConstant.bryteLogoWhite),
          actions: [
            InkWell(
              onTap: () {
                box.remove(KeyConstant.token);
                Get.off(() => const Signin());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Settings',
                    style: BryteTypography.bodyExtraBold
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            )
          ],
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              log('Profile Success');
            } else if (state is ProfileFailure) {
              log('Profile Gagal');
            }
          },
          builder: (context, state) {
            if (state is ProfileSuccess) {
              return SingleChildScrollView(
                child: ValueListenableBuilder(
                  valueListenable: selectedTab,
                  builder: (context, v, c) => Column(children: [
                    ProfileStudent(
                      imageUrl: state.response.users[0].profileimageurl!,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.response.users[0].fullname!,
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
                        children: const [
                          CumulativeCard(),
                          AttendanceRateCard(),
                        ],
                      )
                    else if (v == ProfileTabType.personal)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'NAME',
                              style: BryteTypography.titleMedium
                                  .copyWith(color: Palette.lightGrey),
                            ),
                            const Text(
                              'Farel Julian Suryadi',
                              style: BryteTypography.titleSemiBold,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'STUDENT NUMBER (NUM)',
                              style: BryteTypography.titleMedium
                                  .copyWith(color: Palette.lightGrey),
                            ),
                            const Text(
                              '23601810009',
                              style: BryteTypography.titleSemiBold,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'PROGRAM',
                              style: BryteTypography.titleMedium
                                  .copyWith(color: Palette.lightGrey),
                            ),
                            const Text(
                              'S1 Product Design Engineering',
                              style: BryteTypography.titleSemiBold,
                            ),
                          ],
                        ),
                      )
                  ]),
                ),
              );
            } else if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('Smoething Error'),
              );
            }
          },
        ),
      ),
    );

    // return Center(
    //   child: ElevatedButton(
    //       onPressed: () {
    //         box.remove(KeyConstant.token);
    //         box.remove(KeyConstant.role);
    //         Get.offAllNamed(Signin.route);
    //       },
    //       child: const Text('Logout')),
    // );
  }
}

class CumulativeCard extends StatelessWidget {
  const CumulativeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      shadowColor: Palette.lightPurple,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    'Cumulative GPA',
                    style:
                        BryteTypography.headerSemiBold.copyWith(fontSize: 15),
                  ),
                ),
                Text(
                  '3.98',
                  style: BryteTypography.headerExtraBold.copyWith(
                    fontSize: 48,
                    color: Palette.purple,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.to(
                        () => const AllScorePage(),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'All Scores',
                            style: BryteTypography.titleSemiBold.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Palette.purple,
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: Palette.purple,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CircularStepProgressIndicator(
              totalSteps: 100,
              currentStep: 80,
              stepSize: 10,
              selectedColor: Palette.purple,
              unselectedColor: Colors.grey[200],
              padding: 0,
              width: 100,
              height: 100,
              selectedStepSize: 15,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '3.81',
                      style: BryteTypography.titleExtraBold
                          .copyWith(color: Palette.purple),
                    ),
                    Text(
                      '/4.00',
                      style: BryteTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Palette.grey1),
                    ),
                  ],
                ),
              ),
              roundedCap: (_, __) => true,
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceRateCard extends StatelessWidget {
  const AttendanceRateCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      shadowColor: Palette.lightPurple,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    'Current\nAttendance Rate',
                    style:
                        BryteTypography.headerSemiBold.copyWith(fontSize: 15),
                  ),
                ),
                Text(
                  '90%',
                  style: BryteTypography.headerExtraBold.copyWith(
                    fontSize: 48,
                    color: Palette.purple,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.to(
                        () => const AllAttendancePage(),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'All Attendance',
                            style: BryteTypography.titleSemiBold.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Palette.purple,
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: Palette.purple,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CircularStepProgressIndicator(
              totalSteps: 100,
              currentStep: 80,
              stepSize: 10,
              selectedColor: Palette.purple,
              unselectedColor: Colors.grey[200],
              padding: 0,
              width: 100,
              height: 100,
              selectedStepSize: 15,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '90',
                    style: BryteTypography.titleExtraBold
                        .copyWith(color: Palette.purple),
                  ),
                  Text(
                    '/100',
                    style: BryteTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Palette.grey1),
                  ),
                ],
              )),
              roundedCap: (_, __) => true,
            ),
          ],
        ),
      ),
    );
  }
}

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
              ProfileTabType.proggress: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Proggress',
                  style: brytStylebtn.copyWith(
                      color: selectedValue.value != ProfileTabType.proggress
                          ? Palette.headerSpecial
                          : Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
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

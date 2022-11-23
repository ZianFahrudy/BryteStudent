// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:developer';

import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/core/blocs/attendance_rate/attendance_rate_bloc.dart';
import 'package:bryte/core/blocs/gpa_grade/gpa_grade_bloc.dart';
import 'package:bryte/core/blocs/list_semester_student/list_semester_student_bloc.dart';
import 'package:bryte/core/blocs/profile/profile_bloc.dart';
import 'package:bryte/core/data/model/profile/request/gpa_grade_body.dart';
import 'package:bryte/core/data/model/profile/request/profile_body.dart';
import 'package:bryte/core/data/model/profile/response/profile_model.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/data/model/profile/request/attendance_rate_student.dart';
import '../local_widgets/profile_content.dart';
import '../local_widgets/segmented_profile.dart';
import '../local_widgets/setting_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final selectedTab = ValueNotifier<ProfileTabType>(ProfileTabType.academic);
  final profileBloc = getIt<ProfileBloc>();
  final attendanceRateBloc = getIt<AttendanceRateBloc>();
  final listSemesterStudentBloc = getIt<ListSemesterStudentBloc>();
  final gpaGradeBloc = getIt<GpaGradeBloc>();
  List<String> currentAttd = [];
  double gpaScore = 0.0;
  String totalSks = '';
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => profileBloc
            ..add(GetUserProfileEvent(
              body: ProfileBody(
                wstoken: token,
                wsfunction: 'core_user_get_users',
                moodlewsrestformat: 'json',
                criteriaid: 'id',
                criteriauserid: int.parse(userId),
              ),
            )),
        ),
        BlocProvider(
          create: (context) => attendanceRateBloc
            ..add(
              GetAttendanceRateStudentEvent(
                body: AttendanceRateStudentBody(
                  token: token,
                  userid: userId,
                  idAperiod: '',
                ),
              ),
            ),
        ),
        BlocProvider(
          create: (context) => gpaGradeBloc
            ..add(
              GetGpaGradeEvent(
                body: GpaGradeBody(
                  token: token,
                  userid: userId,
                  semester: '0',
                ),
              ),
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            AssetConstant.bryteLogoWhite,
            width: 59,
          ),
          actions: [
            SettingButton(user: user),
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileSuccess) {
                  user = state.response.users[0];
                  log('Profile Success');
                  box.write(KeyConstant.profileImage,
                      state.response.users[0].profileimageurl);
                } else if (state is ProfileFailure) {
                  log('Profile Gagal');
                }
              },
            ),
            BlocListener<AttendanceRateBloc, AttendanceRateState>(
              listener: (context, state) {
                if (state is AttendanceRateSuccess) {
                  currentAttd = state.response.data[0].attdRate;

                  log(state.response.data[0].attdRate.first,
                      name: 'ATTENDANCE RATE LOG');
                  setState(() {});
                }
              },
            ),
            BlocListener<GpaGradeBloc, GpaGradeState>(
              listener: (context, state) {
                if (state is GpaGradeSuccess) {
                  gpaScore = state.response.data[0].finalGpa;
                  totalSks = state.response.data[0].totSks.toString();
                  setState(() {});
                  log(gpaScore.toString(), name: 'GPA SKOR');
                }
              },
            ),
          ],
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileSuccess) {
                return ProfileContent(
                  state: state,
                  selectedTab: selectedTab,
                  gpaGradeBloc: gpaGradeBloc,
                  gpaScore: gpaScore,
                  totalSks: totalSks,
                  currentAttd: currentAttd,
                );
              } else if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text('Something Error'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

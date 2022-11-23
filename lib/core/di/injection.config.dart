// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../presentation/navigation/cubits/nav_course/nav_course_cubit.dart'
    as _i9;
import '../blocs/academic_period/academic_period_bloc.dart' as _i14;
import '../blocs/assignment/assignment_bloc.dart' as _i15;
import '../blocs/attend/attend_bloc.dart' as _i16;
import '../blocs/attend/bloc/attend_list_bloc.dart' as _i17;
import '../blocs/attendance_rate/attendance_rate_bloc.dart' as _i18;
import '../blocs/attendance_rate/bloc/attendance_rate_det_bloc.dart' as _i19;
import '../blocs/auth/auth_bloc.dart' as _i20;
import '../blocs/calendar/event_bloc.dart' as _i23;
import '../blocs/class/class_bloc.dart' as _i21;
import '../blocs/course/course_bloc.dart' as _i22;
import '../blocs/edit_submission/edit_submission_bloc.dart' as _i6;
import '../blocs/gpa_grade/gpa_grade_bloc.dart' as _i24;
import '../blocs/list_semester_student/list_semester_student_bloc.dart' as _i25;
import '../blocs/master_section/master_section_bloc.dart' as _i7;
import '../blocs/moodle/moodle_bloc.dart' as _i26;
import '../blocs/participant/participant_bloc.dart' as _i27;
import '../blocs/profile/profile_bloc.dart' as _i28;
import '../blocs/score/score_bloc.dart' as _i29;
import '../blocs/student/student_bloc.dart' as _i30;
import '../blocs/summary/summary_bloc.dart' as _i12;
import '../blocs/upcoming/upcoming_bloc.dart' as _i13;
import '../repo/auth/auth_repository.dart' as _i3;
import '../repo/authentication/authentication_repository.dart' as _i4;
import '../repo/course/course_repository.dart' as _i5;
import '../repo/moodle/moodle_repository.dart' as _i8;
import '../repo/profile/profile_repository.dart' as _i10;
import '../repo/student/student_repository.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthRepository>(() => _i3.AuthRepository());
  gh.lazySingleton<_i4.AuthenticationRepository>(
      () => _i4.AuthenticationRepositoryImpl());
  gh.lazySingleton<_i5.CourseRepository>(() => _i5.CourseRepositoryImpl());
  gh.factory<_i6.EditSubmissionBloc>(
      () => _i6.EditSubmissionBloc(get<_i5.CourseRepository>()));
  gh.factory<_i7.MasterSectionBloc>(
      () => _i7.MasterSectionBloc(get<_i5.CourseRepository>()));
  gh.lazySingleton<_i8.MoodleRepository>(() => _i8.MoodleRepositoryImpl());
  gh.factory<_i9.NavCourseCubit>(() => _i9.NavCourseCubit());
  gh.lazySingleton<_i10.ProfileRepository>(() => _i10.ProfileRepositoryImpl());
  gh.lazySingleton<_i11.StudentRepository>(() => _i11.StudentRepositoryImpl());
  gh.factory<_i12.SummaryBloc>(
      () => _i12.SummaryBloc(get<_i11.StudentRepository>()));
  gh.factory<_i13.UpcomingBloc>(
      () => _i13.UpcomingBloc(get<_i11.StudentRepository>()));
  gh.factory<_i14.AcademicPeriodBloc>(
      () => _i14.AcademicPeriodBloc(get<_i10.ProfileRepository>()));
  gh.factory<_i15.AssignmentBloc>(
      () => _i15.AssignmentBloc(get<_i5.CourseRepository>()));
  gh.factory<_i16.AttendBloc>(
      () => _i16.AttendBloc(get<_i11.StudentRepository>()));
  gh.factory<_i17.AttendListBloc>(
      () => _i17.AttendListBloc(get<_i11.StudentRepository>()));
  gh.factory<_i18.AttendanceRateBloc>(
      () => _i18.AttendanceRateBloc(get<_i10.ProfileRepository>()));
  gh.factory<_i19.AttendanceRateDetBloc>(
      () => _i19.AttendanceRateDetBloc(get<_i10.ProfileRepository>()));
  gh.factory<_i20.AuthBloc>(() => _i20.AuthBloc(get<_i3.AuthRepository>()));
  gh.factory<_i21.ClassBloc>(
      () => _i21.ClassBloc(get<_i11.StudentRepository>()));
  gh.factory<_i22.CourseBloc>(
      () => _i22.CourseBloc(get<_i5.CourseRepository>()));
  gh.factory<_i23.EventBloc>(
      () => _i23.EventBloc(get<_i11.StudentRepository>()));
  gh.factory<_i24.GpaGradeBloc>(
      () => _i24.GpaGradeBloc(get<_i10.ProfileRepository>()));
  gh.factory<_i25.ListSemesterStudentBloc>(
      () => _i25.ListSemesterStudentBloc(get<_i10.ProfileRepository>()));
  gh.factory<_i26.MoodleBloc>(
      () => _i26.MoodleBloc(get<_i8.MoodleRepository>()));
  gh.factory<_i27.ParticipantBloc>(
      () => _i27.ParticipantBloc(get<_i11.StudentRepository>()));
  gh.factory<_i28.ProfileBloc>(
      () => _i28.ProfileBloc(get<_i10.ProfileRepository>()));
  gh.factory<_i29.ScoreBloc>(
      () => _i29.ScoreBloc(get<_i11.StudentRepository>()));
  gh.factory<_i30.StudentBloc>(
      () => _i30.StudentBloc(get<_i11.StudentRepository>()));
  return get;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../blocs/assignment/assignment_bloc.dart' as _i11;
import '../blocs/attend/attend_bloc.dart' as _i12;
import '../blocs/auth/auth_bloc.dart' as _i13;
import '../blocs/calendar/event_bloc.dart' as _i16;
import '../blocs/class/class_bloc.dart' as _i14;
import '../blocs/course/course_bloc.dart' as _i15;
import '../blocs/moodle/moodle_bloc.dart' as _i17;
import '../blocs/profile/profile_bloc.dart' as _i18;
import '../blocs/student/student_bloc.dart' as _i19;
import '../blocs/summary/summary_bloc.dart' as _i9;
import '../blocs/upcoming/upcoming_bloc.dart' as _i10;
import '../repo/auth/auth_repository.dart' as _i3;
import '../repo/authentication/authentication_repository.dart' as _i4;
import '../repo/course/course_repository.dart' as _i5;
import '../repo/moodle/moodle_repository.dart' as _i6;
import '../repo/profile/profile_repository.dart' as _i7;
import '../repo/student/student_repository.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthRepository>(() => _i3.AuthRepository());
  gh.lazySingleton<_i4.AuthenticationRepository>(
      () => _i4.AuthenticationRepositoryImpl());
  gh.lazySingleton<_i5.CourseRepository>(() => _i5.CourseRepositoryImpl());
  gh.lazySingleton<_i6.MoodleRepository>(() => _i6.MoodleRepositoryImpl());
  gh.lazySingleton<_i7.ProfileRepository>(() => _i7.ProfileRepositoryImpl());
  gh.lazySingleton<_i8.StudentRepository>(() => _i8.StudentRepositoryImpl());
  gh.factory<_i9.SummaryBloc>(
      () => _i9.SummaryBloc(get<_i8.StudentRepository>()));
  gh.factory<_i10.UpcomingBloc>(
      () => _i10.UpcomingBloc(get<_i8.StudentRepository>()));
  gh.factory<_i11.AssignmentBloc>(
      () => _i11.AssignmentBloc(get<_i5.CourseRepository>()));
  gh.factory<_i12.AttendBloc>(
      () => _i12.AttendBloc(get<_i8.StudentRepository>()));
  gh.factory<_i13.AuthBloc>(() => _i13.AuthBloc(get<_i3.AuthRepository>()));
  gh.factory<_i14.ClassBloc>(
      () => _i14.ClassBloc(get<_i8.StudentRepository>()));
  gh.factory<_i15.CourseBloc>(
      () => _i15.CourseBloc(get<_i5.CourseRepository>()));
  gh.factory<_i16.EventBloc>(
      () => _i16.EventBloc(get<_i8.StudentRepository>()));
  gh.factory<_i17.MoodleBloc>(
      () => _i17.MoodleBloc(get<_i6.MoodleRepository>()));
  gh.factory<_i18.ProfileBloc>(
      () => _i18.ProfileBloc(get<_i7.ProfileRepository>()));
  gh.factory<_i19.StudentBloc>(
      () => _i19.StudentBloc(get<_i8.StudentRepository>()));
  return get;
}

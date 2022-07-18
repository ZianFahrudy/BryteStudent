// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../blocs/assignment/assignment_bloc.dart' as _i10;
import '../blocs/attend/attend_bloc.dart' as _i11;
import '../blocs/auth/auth_bloc.dart' as _i3;
import '../blocs/calendar/event_bloc.dart' as _i14;
import '../blocs/class/class_bloc.dart' as _i12;
import '../blocs/course/course_bloc.dart' as _i13;
import '../blocs/profile/profile_bloc.dart' as _i15;
import '../blocs/student/student_bloc.dart' as _i16;
import '../blocs/summary/summary_bloc.dart' as _i8;
import '../blocs/upcoming/upcoming_bloc.dart' as _i9;
import '../repo/auth/auth_repository.dart' as _i4;
import '../repo/course/course_repository.dart' as _i5;
import '../repo/profile/profile_repository.dart' as _i6;
import '../repo/student/student_repository.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthBloc>(() => _i3.AuthBloc(get<_i4.AuthRepository>()));
  gh.lazySingleton<_i5.CourseRepository>(() => _i5.CourseRepositoryImpl());
  gh.lazySingleton<_i6.ProfileRepository>(() => _i6.ProfileRepositoryImpl());
  gh.lazySingleton<_i7.StudentRepository>(() => _i7.StudentRepositoryImpl());
  gh.factory<_i8.SummaryBloc>(
      () => _i8.SummaryBloc(get<_i7.StudentRepository>()));
  gh.factory<_i9.UpcomingBloc>(
      () => _i9.UpcomingBloc(get<_i7.StudentRepository>()));
  gh.factory<_i10.AssignmentBloc>(
      () => _i10.AssignmentBloc(get<_i5.CourseRepository>()));
  gh.factory<_i11.AttendBloc>(
      () => _i11.AttendBloc(get<_i7.StudentRepository>()));
  gh.factory<_i12.ClassBloc>(
      () => _i12.ClassBloc(get<_i7.StudentRepository>()));
  gh.factory<_i13.CourseBloc>(
      () => _i13.CourseBloc(get<_i5.CourseRepository>()));
  gh.factory<_i14.EventBloc>(
      () => _i14.EventBloc(get<_i7.StudentRepository>()));
  gh.factory<_i15.ProfileBloc>(
      () => _i15.ProfileBloc(get<_i6.ProfileRepository>()));
  gh.factory<_i16.StudentBloc>(
      () => _i16.StudentBloc(get<_i7.StudentRepository>()));
  return get;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../blocs/assignment/assignment_bloc.dart' as _i9;
import '../blocs/attend/attend_bloc.dart' as _i10;
import '../blocs/auth/auth_bloc.dart' as _i3;
import '../blocs/calendar/event_bloc.dart' as _i13;
import '../blocs/class/class_bloc.dart' as _i11;
import '../blocs/course/course_bloc.dart' as _i12;
import '../blocs/student/student_bloc.dart' as _i14;
import '../blocs/summary/summary_bloc.dart' as _i7;
import '../blocs/upcoming/upcoming_bloc.dart' as _i8;
import '../repo/auth/auth_repository.dart' as _i4;
import '../repo/course/course_repository.dart' as _i5;
import '../repo/student/student_repository.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthBloc>(() => _i3.AuthBloc(get<_i4.AuthRepository>()));
  gh.lazySingleton<_i5.CourseRepository>(() => _i5.CourseRepositoryImpl());
  gh.lazySingleton<_i6.StudentRepository>(() => _i6.StudentRepositoryImpl());
  gh.factory<_i7.SummaryBloc>(
      () => _i7.SummaryBloc(get<_i6.StudentRepository>()));
  gh.factory<_i8.UpcomingBloc>(
      () => _i8.UpcomingBloc(get<_i6.StudentRepository>()));
  gh.factory<_i9.AssignmentBloc>(
      () => _i9.AssignmentBloc(get<_i5.CourseRepository>()));
  gh.factory<_i10.AttendBloc>(
      () => _i10.AttendBloc(get<_i6.StudentRepository>()));
  gh.factory<_i11.ClassBloc>(
      () => _i11.ClassBloc(get<_i6.StudentRepository>()));
  gh.factory<_i12.CourseBloc>(
      () => _i12.CourseBloc(get<_i5.CourseRepository>()));
  gh.factory<_i13.EventBloc>(
      () => _i13.EventBloc(get<_i6.StudentRepository>()));
  gh.factory<_i14.StudentBloc>(
      () => _i14.StudentBloc(get<_i6.StudentRepository>()));
  return get;
}

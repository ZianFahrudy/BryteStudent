// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../blocs/attend/attend_bloc.dart' as _i8;
import '../blocs/auth/auth_bloc.dart' as _i3;
import '../blocs/calendar/event_bloc.dart' as _i10;
import '../blocs/class/class_bloc.dart' as _i9;
import '../blocs/student/student_bloc.dart' as _i11;
import '../blocs/summary/summary_bloc.dart' as _i6;
import '../blocs/upcoming/upcoming_bloc.dart' as _i7;
import '../repo/auth/auth_repository.dart' as _i4;
import '../repo/student/student_repository.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthBloc>(() => _i3.AuthBloc(get<_i4.AuthRepository>()));
  gh.lazySingleton<_i5.StudentRepository>(() => _i5.StudentRepositoryImpl());
  gh.factory<_i6.SummaryBloc>(
      () => _i6.SummaryBloc(get<_i5.StudentRepository>()));
  gh.factory<_i7.UpcomingBloc>(
      () => _i7.UpcomingBloc(get<_i5.StudentRepository>()));
  gh.factory<_i8.AttendBloc>(
      () => _i8.AttendBloc(get<_i5.StudentRepository>()));
  gh.factory<_i9.ClassBloc>(() => _i9.ClassBloc(get<_i5.StudentRepository>()));
  gh.factory<_i10.EventBloc>(
      () => _i10.EventBloc(get<_i5.StudentRepository>()));
  gh.factory<_i11.StudentBloc>(
      () => _i11.StudentBloc(get<_i5.StudentRepository>()));
  return get;
}

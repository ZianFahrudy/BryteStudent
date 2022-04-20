// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../auth/auth_bloc.dart' as _i3;
import '../repo/auth/auth_repository.dart' as _i4;
import '../repo/student/student_repository.dart' as _i5;
import '../student/class/class_bloc.dart' as _i8;
import '../student/student_bloc.dart' as _i9;
import '../student/summary/summary_bloc.dart' as _i6;
import '../student/upcoming/upcoming_bloc.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i8.ClassBloc>(() => _i8.ClassBloc(get<_i5.StudentRepository>()));
  gh.factory<_i9.StudentBloc>(
      () => _i9.StudentBloc(get<_i5.StudentRepository>()));
  return get;
}

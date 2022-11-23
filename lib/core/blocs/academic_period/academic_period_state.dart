part of 'academic_period_bloc.dart';

@immutable
abstract class AcademicPeriodState {}

class AcademicPeriodInitial extends AcademicPeriodState {}

class AcademicPeriodLoading extends AcademicPeriodState {}

class AcademicPeriodFailure extends AcademicPeriodState {
  final String msg;
  AcademicPeriodFailure({
    required this.msg,
  });
}

class AcademicPeriodSuccess extends AcademicPeriodState {
  final PeriodPerStudentModel response;
  AcademicPeriodSuccess({
    required this.response,
  });
}

part of 'academic_period_bloc.dart';

@immutable
abstract class AcademicPeriodEvent {}

class GetAcademicPeriodStudentEvent extends AcademicPeriodEvent {
  final PeriodStudentBody body;

  GetAcademicPeriodStudentEvent({
    required this.body,
  });
}

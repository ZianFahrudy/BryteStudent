part of 'summary_bloc.dart';

@immutable
abstract class SummaryState {}

class ClassInitial extends SummaryState {}

class ClassSummaryStudentLoading extends SummaryState {}

class ClassSummaryStudentFailure extends SummaryState {
  final String msg;
  ClassSummaryStudentFailure(this.msg);
}

class ClassSummaryStudentSuccess extends SummaryState {
  final ClassSummaryStudentModel response;
  ClassSummaryStudentSuccess({
    required this.response,
  });
}

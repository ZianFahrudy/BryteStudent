part of 'summary_bloc.dart';

@immutable
abstract class SummaryEvent {}

class GetClassSummaryStudent extends SummaryEvent {
  final ClassSummaryStudentBody body;
  GetClassSummaryStudent(
    this.body,
  );
}

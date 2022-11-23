part of 'gpa_grade_bloc.dart';

@immutable
abstract class GpaGradeEvent {}

class GetGpaGradeEvent extends GpaGradeEvent {
  final GpaGradeBody body;
  GetGpaGradeEvent({
    required this.body,
  });
}

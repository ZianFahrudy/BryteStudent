part of 'gpa_grade_bloc.dart';

@immutable
abstract class GpaGradeState {}

class GpaGradeInitial extends GpaGradeState {}

class GpaGradeLoading extends GpaGradeState {}

class GpaGradeSuccess extends GpaGradeState {
  final GpaGradeModel response;
  GpaGradeSuccess({
    required this.response,
  });
}

class GpaGradeFailure extends GpaGradeState {
  final String msg;
  GpaGradeFailure({
    required this.msg,
  });
}

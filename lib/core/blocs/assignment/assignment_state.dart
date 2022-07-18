part of 'assignment_bloc.dart';

@immutable
abstract class AssignmentState {}

class AssignmentInitial extends AssignmentState {}

class AssignmentLoading extends AssignmentState {}

class AssignmentSuccess extends AssignmentState {
  final AssignmentModel response;
  AssignmentSuccess({
    required this.response,
  });
}

class AssignmentFailure extends AssignmentState {
  final String msg;
  AssignmentFailure({
    required this.msg,
  });
}

class DetailAssignmentSuccess extends AssignmentState {
  final DetailAssignmentModel response;
  DetailAssignmentSuccess({
    required this.response,
  });
}

class AssignmentPerCourseSuccess extends AssignmentState {
  final AssignmentPerCourseModel response;
  AssignmentPerCourseSuccess({
    required this.response,
  });
}

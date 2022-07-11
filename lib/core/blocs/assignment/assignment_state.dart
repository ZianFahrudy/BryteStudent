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

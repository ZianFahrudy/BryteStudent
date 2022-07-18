part of 'assignment_bloc.dart';

@immutable
abstract class AssignmentEvent {}

class GetCourseAssignment extends AssignmentEvent {
  final CourseBody body;
  GetCourseAssignment({
    required this.body,
  });
}

class GetDetailAssignmentEvent extends AssignmentEvent {
  final DetailAssignmentBody body;
  GetDetailAssignmentEvent({
    required this.body,
  });
}

class GetAssignmentPerCourseEvent extends AssignmentEvent {
  final AssignmentPerCourseBody body;
  GetAssignmentPerCourseEvent({
    required this.body,
  });
}

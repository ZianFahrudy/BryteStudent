part of 'assignment_bloc.dart';

@immutable
abstract class AssignmentEvent {}

class GetCourseAssignment extends AssignmentEvent {
  final CourseBody body;
  GetCourseAssignment({
    required this.body,
  });
}

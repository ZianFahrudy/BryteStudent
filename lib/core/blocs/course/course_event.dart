part of 'course_bloc.dart';

@immutable
abstract class CourseEvent {}

class GetGeneralCourseEvent extends CourseEvent {
  final GeneralCourseBody body;
  GetGeneralCourseEvent({
    required this.body,
  });
}

class GetCourseEvent extends CourseEvent {
  final CourseBody body;
  GetCourseEvent({
    required this.body,
  });
}

class GetAssignmentCourse extends CourseEvent {
  final CourseBody body;
  GetAssignmentCourse({
    required this.body,
  });
}

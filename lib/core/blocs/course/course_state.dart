part of 'course_bloc.dart';

@immutable
abstract class CourseState {}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseSuccess extends CourseState {
  CourseSuccess({
    required this.response,
  });
  final List<CourseGeneralModel> response;
}

class CourseFailed extends CourseState {
  CourseFailed({
    required this.msg,
  });
  final String msg;
}

class CourseStudentSuccess extends CourseState {
  final CourseModel response;
  CourseStudentSuccess({
    required this.response,
  });
}

class CourseStudentLoading extends CourseState {}

class CourseAssignmentSuccess extends CourseState {
  final AssignmentModel response;
  CourseAssignmentSuccess({
    required this.response,
  });
}

class CourseAssignmentLoading extends CourseState {}

class CourseAssignmentFailure extends CourseState {
  final String msg;
  CourseAssignmentFailure({
    required this.msg,
  });
}

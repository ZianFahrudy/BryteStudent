part of 'nav_course_cubit.dart';

@immutable
abstract class NavCourseState {}

class NavCourseInitial extends NavCourseState {}

class NavCourseSuccess extends NavCourseState {
  final bool isCourse;
  NavCourseSuccess({
    required this.isCourse,
  });
}

class NavCourseFailure extends NavCourseState {
  final String msg;
  NavCourseFailure({
    required this.msg,
  });
}

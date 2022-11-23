part of 'list_semester_student_bloc.dart';

@immutable
abstract class ListSemesterStudentState {}

class ListSemesterStudentInitial extends ListSemesterStudentState {}

class ListSemesterStudentLoading extends ListSemesterStudentState {}

class ListSemesterStudentSuccess extends ListSemesterStudentState {
  final ListSemesterStudentModel response;
  ListSemesterStudentSuccess({
    required this.response,
  });
}

class ListSemesterStudentFailure extends ListSemesterStudentState {
  final String msg;
  ListSemesterStudentFailure({
    required this.msg,
  });
}

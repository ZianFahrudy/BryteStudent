part of 'list_semester_student_bloc.dart';

@immutable
abstract class ListSemesterStudentEvent {}

class GetListSemesterStudentEvent extends ListSemesterStudentEvent {
  final ListSemesterStudentBody body;
  GetListSemesterStudentEvent({
    required this.body,
  });
}

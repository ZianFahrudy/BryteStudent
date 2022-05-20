part of 'student_bloc.dart';

@immutable
abstract class StudentState {}

// class summary
class ClassSummaryStudentInitial extends StudentState {}

// announcement
class AnnouncementSuccess extends StudentState {
  final AnnouncementModel response;
  AnnouncementSuccess({
    required this.response,
  });
}

class AnnouncementLoading extends StudentState {}

class AnnouncementFailure extends StudentState {
  final String msg;
  AnnouncementFailure(this.msg);
}

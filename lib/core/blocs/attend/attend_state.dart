part of 'attend_bloc.dart';

@immutable
abstract class AttendState {}

class AttendInitial extends AttendState {}

class AttendLoading extends AttendState {}

class AttendSuccess extends AttendState {
  final String response;
  AttendSuccess({
    required this.response,
  });
}

class AttendFailure extends AttendState {
  final String msg;
  AttendFailure({
    required this.msg,
  });
}

class AttendanceCourseSuccess extends AttendState {
  final AttendanceModel response;
  AttendanceCourseSuccess({
    required this.response,
  });
}

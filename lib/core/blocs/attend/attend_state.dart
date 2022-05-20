part of 'attend_bloc.dart';

@immutable
abstract class AttendState {}

class AttendInitial extends AttendState {}

class AttendLoading extends AttendState {}

class AttendSuccess extends AttendState {
  final MoodleAttendanceModel response;
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

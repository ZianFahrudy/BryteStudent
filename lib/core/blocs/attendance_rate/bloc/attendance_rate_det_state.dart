part of 'attendance_rate_det_bloc.dart';

@immutable
abstract class AttendanceRateDetState {}

class AttendanceRateDetInitial extends AttendanceRateDetState {}

class AttendanceRateDetSuccess extends AttendanceRateDetState {
  final AttendanceRateStudentModel response;
  AttendanceRateDetSuccess({
    required this.response,
  });
}

class AttendanceRateDetFailure extends AttendanceRateDetState {
  final String msg;
  AttendanceRateDetFailure({
    required this.msg,
  });
}

class AttendanceRateDetLoading extends AttendanceRateDetState {}

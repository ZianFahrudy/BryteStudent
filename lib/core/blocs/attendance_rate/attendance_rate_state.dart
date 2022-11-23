part of 'attendance_rate_bloc.dart';

@immutable
abstract class AttendanceRateState {}

class AttendanceRateInitial extends AttendanceRateState {}

class AttendanceRateSuccess extends AttendanceRateState {
  final AttendanceRatePersentaseModel response;
  AttendanceRateSuccess({
    required this.response,
  });
}

class AttendanceRateLoading extends AttendanceRateState {}

class AttendanceRateFailure extends AttendanceRateState {
  final String msg;
  AttendanceRateFailure({
    required this.msg,
  });
}

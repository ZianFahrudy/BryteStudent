part of 'attendance_rate_bloc.dart';

@immutable
abstract class AttendanceRateEvent {}

class GetAttendanceRateStudentEvent extends AttendanceRateEvent {
  final AttendanceRateStudentBody body;
  GetAttendanceRateStudentEvent({
    required this.body,
  });
}

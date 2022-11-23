part of 'attendance_rate_det_bloc.dart';

@immutable
abstract class AttendanceRateDetEvent {}

class GetAttendaceRateDetEvent extends AttendanceRateDetEvent {
  final AttendanceRateStudentBody body;
  GetAttendaceRateDetEvent({
    required this.body,
  });
}

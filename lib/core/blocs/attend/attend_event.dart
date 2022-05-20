part of 'attend_bloc.dart';

@immutable
abstract class AttendEvent {}

class SubmitAttendance extends AttendEvent {
  final SubmitAttendanceBody body;
  SubmitAttendance(
    this.body,
  );
}

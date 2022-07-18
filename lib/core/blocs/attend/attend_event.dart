part of 'attend_bloc.dart';

@immutable
abstract class AttendEvent {}

class SubmitAttendance extends AttendEvent {
  final SubmitAttendanceBody body;
  SubmitAttendance(
    this.body,
  );
}

class GetAttendanceEvent extends AttendEvent {
  final AttendanceBody body;
  GetAttendanceEvent({
    required this.body,
  });
}

part of 'attend_list_bloc.dart';

@immutable
abstract class AttendListEvent {}

class GetAttendListEvent extends AttendListEvent {
  final AttendanceBody body;
  GetAttendListEvent({
    required this.body,
  });
}

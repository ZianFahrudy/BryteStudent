part of 'student_bloc.dart';

@immutable
abstract class StudentEvent {}

class GetAnnouncementEvent extends StudentEvent {
  final AnnouncementBody body;
  GetAnnouncementEvent(
    this.body,
  );
}

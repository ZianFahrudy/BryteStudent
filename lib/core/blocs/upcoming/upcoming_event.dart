part of 'upcoming_bloc.dart';

@immutable
abstract class UpcomingEvent {}

class GetUpcomingAssignEvent extends UpcomingEvent {
  final UpcomingAssignBody body;
  GetUpcomingAssignEvent({
    required this.body,
  });
}

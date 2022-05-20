part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class GetCalendarEvent extends EventEvent {
  GetCalendarEvent(this.body);
  final EventBody body;
}

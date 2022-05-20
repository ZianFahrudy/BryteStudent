part of 'event_bloc.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventSuccess extends EventState {
  EventSuccess(this.response);

  final CalendarEventModel response;
}

class EventFailure extends EventState {
  EventFailure(this.msg);
  final String msg;
}

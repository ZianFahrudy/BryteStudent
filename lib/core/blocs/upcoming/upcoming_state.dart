part of 'upcoming_bloc.dart';

@immutable
abstract class UpcomingState {}

class UpcomingInitial extends UpcomingState {}

class UpcomingLoading extends UpcomingState {}

class UpcomingSuccess extends UpcomingState {
  final UpcomingAssignModel response;
  UpcomingSuccess({
    required this.response,
  });
}

class UpcomingFailure extends UpcomingState {
  final String msg;
  UpcomingFailure({
    required this.msg,
  });
}

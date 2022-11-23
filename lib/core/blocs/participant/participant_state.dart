part of 'participant_bloc.dart';

@immutable
abstract class ParticipantState {}

class ParticipantInitial extends ParticipantState {}

class ParticipantLoading extends ParticipantState {}

class ParticipantSuccess extends ParticipantState {
  final ParticipantModel response;
  ParticipantSuccess({
    required this.response,
  });
}

class ParticipantFailure extends ParticipantState {
  final String msg;
  ParticipantFailure({
    required this.msg,
  });
}

part of 'participant_bloc.dart';

@immutable
abstract class ParticipantEvent {}

class GetParticipantEvent extends ParticipantEvent {
  final ParticipantBody body;
  GetParticipantEvent({
    required this.body,
  });
}

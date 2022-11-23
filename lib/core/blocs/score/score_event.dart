part of 'score_bloc.dart';

@immutable
abstract class ScoreEvent {}

class GetScoreEvent extends ScoreEvent {
  final ScoreBody body;
  GetScoreEvent({
    required this.body,
  });
}

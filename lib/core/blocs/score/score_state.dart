part of 'score_bloc.dart';

@immutable
abstract class ScoreState {}

class ScoreInitial extends ScoreState {}

class ScoreLoading extends ScoreState {}

class ScoreSuccess extends ScoreState {
  final ScoreModel response;
  ScoreSuccess({
    required this.response,
  });
}

class ScoreFailure extends ScoreState {
  final String msg;
  ScoreFailure({
    required this.msg,
  });
}

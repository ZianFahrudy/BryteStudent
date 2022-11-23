part of 'nav_announce_cubit.dart';

@immutable
abstract class NavAnnounceState {}

class NavAnnounceInitial extends NavAnnounceState {}

class NavAnnounceSuccess extends NavAnnounceState {
  final bool isAnnounce;
  NavAnnounceSuccess({
    required this.isAnnounce,
  });
}

class NavAnnounceFailure extends NavAnnounceState {
  final String msg;
  NavAnnounceFailure({
    required this.msg,
  });
}

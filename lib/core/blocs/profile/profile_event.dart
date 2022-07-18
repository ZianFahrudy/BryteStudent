part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetUserProfileEvent extends ProfileEvent {
  final ProfileBody body;
  GetUserProfileEvent({
    required this.body,
  });
}

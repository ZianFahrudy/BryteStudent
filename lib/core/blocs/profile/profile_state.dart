part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileModel response;
  ProfileSuccess({
    required this.response,
  });
}

class ProfileFailure extends ProfileState {
  final String msg;
  ProfileFailure({
    required this.msg,
  });
}

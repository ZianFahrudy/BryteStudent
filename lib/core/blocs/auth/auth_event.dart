part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class Login extends AuthEvent {
  final String? email;
  final String? password;
  Login({this.email, this.password});
}

class SubmitedForgotPassword extends AuthEvent {
  final String? email;
  SubmitedForgotPassword({this.email});
}

class VerifyOtp extends AuthEvent {
  final String? username;
  final String? otp;
  VerifyOtp({this.username, this.otp});
}

class ResetPassword extends AuthEvent {
  final String? username;
  final String? password;
  ResetPassword({this.username, this.password});
}

class ResenOtp extends AuthEvent {
  final String? username;
  ResenOtp({this.username});
}

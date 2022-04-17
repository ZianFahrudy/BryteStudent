part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthWaiting extends AuthState {}

class AuthError extends AuthState {
  final String? msg;
  final String? kode;
  AuthError(this.msg, this.kode);
}

class AuthSubmited extends AuthState {
  final AuthModel? authModel;
  AuthSubmited({this.authModel});
}

class AuthForgotPasswordError extends AuthState {
  final String? msg;
  final String? kode;
  AuthForgotPasswordError(this.msg, this.kode);
}

class AuthForgotPasswordSubmited extends AuthState {
  final ForgotPasswordModel? forgotPasswordModel;
  AuthForgotPasswordSubmited({this.forgotPasswordModel});
}

class AuthFverifyOtpError extends AuthState {
  final String? msg;
  final String? kode;
  AuthFverifyOtpError(this.msg, this.kode);
}

class AuthFverifyOtpSubmited extends AuthState {
  final OtpdModel? otpdModel;
  AuthFverifyOtpSubmited({this.otpdModel});
}

class AuthResetPasspError extends AuthState {
  final String? msg;
  final String? kode;
  AuthResetPasspError(this.msg, this.kode);
}

class AuthResetPassSubmited extends AuthState {
  final OtpdModel? otpdModel;
  AuthResetPassSubmited({this.otpdModel});
}

class AuthResenOtpError extends AuthState {
  final String? msg;
  final String? kode;
  AuthResenOtpError(this.msg, this.kode);
}

class AuthResenOtpSubmited extends AuthState {
  final OtpdModel? otpdModel;
  AuthResenOtpSubmited({this.otpdModel});
}

class AuthRoleFailure extends AuthState {
  final String msg;
  AuthRoleFailure({
    required this.msg,
  });
}

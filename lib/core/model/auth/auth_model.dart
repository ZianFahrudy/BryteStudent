import 'package:json_annotation/json_annotation.dart';
part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {
  String? error;
  String? errorcode;
  String? token;
  String? privatetoken;
  AuthModel({this.error, this.errorcode, this.token, this.privatetoken});
  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ForgotPasswordModel {
  int? status;
  int? error;
  String? email;
  String? otp;
  DateTime? expireIn;
  String? emailStatus;
  ForgotPasswordModel(
      {this.status,
      this.error,
      this.email,
      this.otp,
      this.expireIn,
      this.emailStatus});
  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordModelToJson(this);
}

@JsonSerializable()
class OtpdModel {
  int? status;
  int? error;
  OtpdModel({
    this.status,
    this.error,
  });
  factory OtpdModel.fromJson(Map<String, dynamic> json) =>
      _$OtpdModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpdModelToJson(this);
}

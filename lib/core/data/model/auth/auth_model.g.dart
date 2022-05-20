// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      error: json['error'] as String?,
      errorcode: json['errorcode'] as String?,
      token: json['token'] as String?,
      privatetoken: json['privatetoken'] as String?,
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'error': instance.error,
      'errorcode': instance.errorcode,
      'token': instance.token,
      'privatetoken': instance.privatetoken,
    };

ForgotPasswordModel _$ForgotPasswordModelFromJson(Map<String, dynamic> json) =>
    ForgotPasswordModel(
      status: json['status'] as int?,
      error: json['error'] as int?,
      email: json['email'] as String?,
      otp: json['otp'] as String?,
      expireIn: json['expire_in'] == null
          ? null
          : DateTime.parse(json['expire_in'] as String),
      emailStatus: json['email_status'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordModelToJson(
        ForgotPasswordModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'email': instance.email,
      'otp': instance.otp,
      'expire_in': instance.expireIn?.toIso8601String(),
      'email_status': instance.emailStatus,
    };

OtpdModel _$OtpdModelFromJson(Map<String, dynamic> json) => OtpdModel(
      status: json['status'] as int?,
      error: json['error'] as int?,
    );

Map<String, dynamic> _$OtpdModelToJson(OtpdModel instance) => <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
    };

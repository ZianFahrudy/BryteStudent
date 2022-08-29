import 'package:json_annotation/json_annotation.dart';

part 'reset_password_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class RetypePasswordBody {
  final String username;
  final String password;
  final String retypePassword;
  RetypePasswordBody({
    required this.username,
    required this.password,
    required this.retypePassword,
  });

  Map<String, dynamic> toJson() => _$RetypePasswordBodyToJson(this);
}

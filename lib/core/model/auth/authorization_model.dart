import 'package:json_annotation/json_annotation.dart';

part 'authorization_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class AuthorizationModel {
  final int status;
  final String userid;
  final String roleCode;
  final String roleDescp;
  AuthorizationModel({
    required this.status,
    required this.userid,
    required this.roleCode,
    required this.roleDescp,
  });

  factory AuthorizationModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationModelFromJson(json);
}

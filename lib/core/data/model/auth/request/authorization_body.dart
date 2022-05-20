import 'package:json_annotation/json_annotation.dart';

part 'authorization_body.g.dart';

@JsonSerializable(createFactory: false)
class AuthorizationBody {
  final String token;
  final String username;
  AuthorizationBody({
    required this.token,
    required this.username,
  });

  Map<String, dynamic> toJson() => _$AuthorizationBodyToJson(this);
}

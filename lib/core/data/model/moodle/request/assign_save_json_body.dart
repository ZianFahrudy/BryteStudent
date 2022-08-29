import 'package:json_annotation/json_annotation.dart';

part 'assign_save_json_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
)
class AssignSaveJsonBody {
  final String token;
  final String userid;

  AssignSaveJsonBody({
    required this.token,
    required this.userid,
  });

  Map<String, dynamic> toJson() => _$AssignSaveJsonBodyToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'master_section_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class MasterSectionBody {
  final String token;
  final String userid;
  @JsonKey(name: 'idCourse')
  final String idCourse;
  MasterSectionBody({
    required this.token,
    required this.userid,
    required this.idCourse,
  });

  Map<String, dynamic> toJson() => _$MasterSectionBodyToJson(this);
}

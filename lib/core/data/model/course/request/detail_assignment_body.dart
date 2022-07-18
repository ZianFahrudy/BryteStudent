import 'package:json_annotation/json_annotation.dart';

part 'detail_assignment_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class DetailAssignmentBody {
  final String token;
  final String userid;
  @JsonKey(name: 'idCourse')
  final String idCourse;
  @JsonKey(name: 'idAssign')
  final String idAssign;
  DetailAssignmentBody({
    required this.token,
    required this.userid,
    required this.idCourse,
    required this.idAssign,
  });

  Map<String, dynamic> toJson() => _$DetailAssignmentBodyToJson(this);
}

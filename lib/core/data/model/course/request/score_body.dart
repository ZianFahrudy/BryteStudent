import 'package:json_annotation/json_annotation.dart';

part 'score_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class ScoreBody {
  final String token;
  final String userid;
  @JsonKey(name: 'idCourse')
  final String idCourse;
  ScoreBody({
    required this.token,
    required this.userid,
    required this.idCourse,
  });

  Map<String, dynamic> toJson() => _$ScoreBodyToJson(this);
}

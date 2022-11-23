import 'package:json_annotation/json_annotation.dart';

part 'participant_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class ParticipantBody {
  final String token;
  final String userid;
  @JsonKey(name: 'idCourse')
  final String idCourse;
  final int page;
  ParticipantBody({
    required this.token,
    required this.userid,
    required this.idCourse,
    required this.page,
  });

  Map<String, dynamic> toJson() => _$ParticipantBodyToJson(this);
}

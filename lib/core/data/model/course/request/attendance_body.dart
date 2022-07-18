import 'package:json_annotation/json_annotation.dart';

part 'attendance_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class AttendanceBody {
  final String token;
  final String userid;
  @JsonKey(name: 'idCourse')
  final String idCourse;
  AttendanceBody({
    required this.token,
    required this.userid,
    required this.idCourse,
  });

  Map<String, dynamic> toJson() => _$AttendanceBodyToJson(this);
}

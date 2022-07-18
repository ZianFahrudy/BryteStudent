import 'package:json_annotation/json_annotation.dart';

part 'assignment_per_course_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class AssignmentPerCourseBody {
  final String token;
  final String userid;
  @JsonKey(name: 'idCourse')
  final String idcourse;
  AssignmentPerCourseBody({
    required this.token,
    required this.userid,
    required this.idcourse,
  });

  Map<String, dynamic> toJson() => _$AssignmentPerCourseBodyToJson(this);
}

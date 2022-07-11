import 'package:json_annotation/json_annotation.dart';

part 'course_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
)
class CourseBody {
  final String token;
  final String userid;
  final String type;
  CourseBody({
    required this.token,
    required this.userid,
    required this.type,
  });

  Map<String, dynamic> toJson() => _$CourseBodyToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'general_course_body.g.dart';

@JsonSerializable(
  createFactory: false,
)
class GeneralCourseBody {
  final String wstoken;
  final String wsfunction;
  final String moodlewsrestformat;
  final int courseid;

  GeneralCourseBody({
    required this.wstoken,
    required this.wsfunction,
    required this.moodlewsrestformat,
    required this.courseid,
  });

  Map<String, dynamic> toJson() => _$GeneralCourseBodyToJson(this);
}

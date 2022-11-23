import 'package:json_annotation/json_annotation.dart';

part 'gpa_grade_body.g.dart';

@JsonSerializable(createFactory: false)
class GpaGradeBody {
  final String token;
  final String userid;
  final String semester;
  GpaGradeBody({
    required this.token,
    required this.userid,
    required this.semester,
  });

  Map<String, dynamic> toJson() => _$GpaGradeBodyToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'class_summary_student_body.g.dart';

@JsonSerializable(createFactory: false)
class ClassSummaryStudentBody {
  final String token;
  final String userid;
  ClassSummaryStudentBody({
    required this.token,
    required this.userid,
  });

  Map<String, dynamic> toJson() => _$ClassSummaryStudentBodyToJson(this);
}

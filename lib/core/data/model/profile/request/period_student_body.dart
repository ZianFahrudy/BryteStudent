import 'package:json_annotation/json_annotation.dart';

part 'period_student_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class PeriodStudentBody {
  final String token;
  final String userid;
  PeriodStudentBody({
    required this.token,
    required this.userid,
  });

  Map<String, dynamic> toJson() => _$PeriodStudentBodyToJson(this);
}

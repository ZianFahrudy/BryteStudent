import 'package:json_annotation/json_annotation.dart';

part 'list_semester_student_body.g.dart';

@JsonSerializable(createFactory: false)
class ListSemesterStudentBody {
  final String token;
  final String userid;
  ListSemesterStudentBody({
    required this.token,
    required this.userid,
  });

  Map<String, dynamic> toJson() => _$ListSemesterStudentBodyToJson(this);
}

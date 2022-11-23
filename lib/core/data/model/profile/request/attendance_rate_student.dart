import 'package:json_annotation/json_annotation.dart';

part 'attendance_rate_student.g.dart';

@JsonSerializable(createFactory: false)
class AttendanceRateStudentBody {
  final String token;
  final String userid;
  final String idAperiod;
  AttendanceRateStudentBody({
    required this.token,
    required this.userid,
    required this.idAperiod,
  });

  Map<String, dynamic> toJson() => _$AttendanceRateStudentBodyToJson(this);
}

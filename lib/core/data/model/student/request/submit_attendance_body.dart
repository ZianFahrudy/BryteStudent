import 'package:json_annotation/json_annotation.dart';

part 'submit_attendance_body.g.dart';

@JsonSerializable(createFactory: false)
class SubmitAttendanceBody {
  SubmitAttendanceBody({
    required this.wstoken,
    required this.wsfunction,
    required this.moodlewrestformat,
    required this.sessionid,
    required this.studentid,
    required this.takenbyid,
    required this.statusid,
    required this.statusset,
  });

  final String wstoken;
  final String wsfunction;
  final String moodlewrestformat;
  final int sessionid;
  final int studentid;
  final int takenbyid;
  final int statusid;
  final List<int> statusset;

  Map<String, dynamic> toJson() => _$SubmitAttendanceBodyToJson(this);
}

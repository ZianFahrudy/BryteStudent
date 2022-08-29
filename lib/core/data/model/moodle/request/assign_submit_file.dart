import 'package:json_annotation/json_annotation.dart';

part 'assign_submit_file.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class AssignSubmitFileBody {
  final String wstoken;
  final String wsfunction;
  final String moodlewsrestformat;
  final int assignmentid;
  final int acceptsubmissionstatement;
  AssignSubmitFileBody({
    required this.wstoken,
    required this.wsfunction,
    required this.moodlewsrestformat,
    required this.assignmentid,
    required this.acceptsubmissionstatement,
  });

  Map<String, dynamic> toJson() => _$AssignSubmitFileBodyToJson(this);
}

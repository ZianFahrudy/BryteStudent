import 'package:json_annotation/json_annotation.dart';

part 'edit_submission_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class EditSubmissionBody {
  final String wstoken;
  final String wsfunction;
  final String moodlewsrestformat;
  final int assignid;
  final int userid;
  EditSubmissionBody({
    required this.wstoken,
    required this.wsfunction,
    required this.moodlewsrestformat,
    required this.assignid,
    required this.userid,
  });

  Map<String, dynamic> toJson() => _$EditSubmissionBodyToJson(this);
}

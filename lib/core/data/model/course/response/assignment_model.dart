import 'package:json_annotation/json_annotation.dart';

part 'assignment_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class AssignmentModel {
  final int status;
  final String message;
  final List<DataAssignmentModel> data;
  AssignmentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataAssignmentModel {
  @JsonKey(name: 'idCourse')
  final String idCourse;
  @JsonKey(name: 'idAssign')
  final String idAssign;
  final String courseName;
  final String assignName;
  final String assignDescp;
  final String assignAllowfrom;
  final String assignDeadline;
  final String assignStatus;
  final String bgColor_1;
  final String bgColor_2;
  final String textColor_1;
  final String textColor_2;
  final String dropShadow;
  DataAssignmentModel({
    required this.idCourse,
    required this.idAssign,
    required this.courseName,
    required this.assignName,
    required this.assignDescp,
    required this.assignAllowfrom,
    required this.assignDeadline,
    required this.assignStatus,
    required this.bgColor_1,
    required this.bgColor_2,
    required this.textColor_1,
    required this.textColor_2,
    required this.dropShadow,
  });

  factory DataAssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$DataAssignmentModelFromJson(json);
}

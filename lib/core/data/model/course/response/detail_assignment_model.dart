import 'package:json_annotation/json_annotation.dart';

part 'detail_assignment_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DetailAssignmentModel {
  final int status;
  final String message;
  final List<DataDetailAssignmentModel> data;
  DetailAssignmentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DetailAssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$DetailAssignmentModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataDetailAssignmentModel {
  @JsonKey(name: 'idCourse')
  final String idCourse;
  final String courseName;
  @JsonKey(name: 'idTeacher')
  final String idTeacher;
  final String teacherName;
  final String teacherImg;
  final List<DataAssigmentmentsModel> assignments;
  DataDetailAssignmentModel({
    required this.idCourse,
    required this.courseName,
    required this.idTeacher,
    required this.teacherName,
    required this.teacherImg,
    required this.assignments,
  });

  factory DataDetailAssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$DataDetailAssignmentModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataAssigmentmentsModel {
  @JsonKey(name: 'idAssign')
  final String idAssign;
  final String assignName;
  final String assignDescp;
  final String assignAllowfrom;
  final String assignDeadline;
  final String assignTimeRemaining;
  final String assignStatus;
  final String assignGrade;
  final String assignMaxSize;
  final String assignFileTypes;
  final List<AssignFileModel> assignFile;

  DataAssigmentmentsModel({
    required this.idAssign,
    required this.assignName,
    required this.assignDescp,
    required this.assignAllowfrom,
    required this.assignDeadline,
    required this.assignTimeRemaining,
    required this.assignStatus,
    required this.assignGrade,
    required this.assignMaxSize,
    required this.assignFileTypes,
    required this.assignFile,
  });

  factory DataAssigmentmentsModel.fromJson(Map<String, dynamic> json) =>
      _$DataAssigmentmentsModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class AssignFileModel {
  final String fileName;
  final String fileUrl;
  AssignFileModel({
    required this.fileName,
    required this.fileUrl,
  });

  factory AssignFileModel.fromJson(Map<String, dynamic> json) =>
      _$AssignFileModelFromJson(json);
}

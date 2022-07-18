import 'package:json_annotation/json_annotation.dart';

part 'assignment_per_course_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class AssignmentPerCourseModel {
  final int status;
  final String message;
  final List<DataAssignmentPerCourseModel> data;
  AssignmentPerCourseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssignmentPerCourseModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentPerCourseModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataAssignmentPerCourseModel {
  @JsonKey(name: 'idCourse')
  final String idCourse;
  final String courseName;
  @JsonKey(name: 'idTeacher')
  final String idTeacher;
  final String teacherName;
  final String teacherImg;
  final List<DataAssignmentsListCourseModel> assignments;
  DataAssignmentPerCourseModel({
    required this.idCourse,
    required this.courseName,
    required this.idTeacher,
    required this.teacherName,
    required this.teacherImg,
    required this.assignments,
  });

  factory DataAssignmentPerCourseModel.fromJson(Map<String, dynamic> json) =>
      _$DataAssignmentPerCourseModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataAssignmentsListCourseModel {
  final List<DataAssignmentModel> assignUpcomming;
  final List<DataAssignmentModel> assignPastDue;
  DataAssignmentsListCourseModel({
    required this.assignUpcomming,
    required this.assignPastDue,
  });

  factory DataAssignmentsListCourseModel.fromJson(Map<String, dynamic> json) =>
      _$DataAssignmentsListCourseModelFromJson(json);
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
  final String assignName;
  final String assignDescp;
  final String assignAllowfrom;
  final String assignDeadline;
  final String? assignSubmit;
  final String assignStatus;
  DataAssignmentModel({
    required this.idCourse,
    required this.idAssign,
    required this.assignName,
    required this.assignDescp,
    required this.assignAllowfrom,
    required this.assignDeadline,
    this.assignSubmit,
    required this.assignStatus,
  });

  factory DataAssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$DataAssignmentModelFromJson(json);
}

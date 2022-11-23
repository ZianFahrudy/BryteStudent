import 'package:json_annotation/json_annotation.dart';

part 'list_semester_student_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ListSemesterStudentModel {
  final int status;
  final String message;
  final List<DataSemesterStudentModel> data;
  ListSemesterStudentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ListSemesterStudentModel.fromJson(Map<String, dynamic> json) =>
      _$ListSemesterStudentModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DataSemesterStudentModel {
  final String nim;
  final List<SemesterListModel> listSemester;
  DataSemesterStudentModel({
    required this.nim,
    required this.listSemester,
  });

  factory DataSemesterStudentModel.fromJson(Map<String, dynamic> json) =>
      _$DataSemesterStudentModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class SemesterListModel {
  final String semester;
  final String semesterDescp;
  SemesterListModel({
    required this.semester,
    required this.semesterDescp,
  });

  factory SemesterListModel.fromJson(Map<String, dynamic> json) =>
      _$SemesterListModelFromJson(json);
}

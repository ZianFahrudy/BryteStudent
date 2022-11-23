import 'package:json_annotation/json_annotation.dart';

part 'gpa_grade_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class GpaGradeModel {
  final int status;
  final String message;
  final List<DataGpaGradeModel> data;
  GpaGradeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GpaGradeModel.fromJson(Map<String, dynamic> json) =>
      _$GpaGradeModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DataGpaGradeModel {
  final String nim;
  final String fullname;
  final double finalGpa;
  final int totSks;
  final List<FinalGradeModel> finalGrade;
  DataGpaGradeModel({
    required this.nim,
    required this.fullname,
    required this.finalGpa,
    required this.totSks,
    required this.finalGrade,
  });

  factory DataGpaGradeModel.fromJson(Map<String, dynamic> json) =>
      _$DataGpaGradeModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class FinalGradeModel {
  final String semester;
  final List<GradeListModel> grade;
  FinalGradeModel({
    required this.semester,
    required this.grade,
  });

  factory FinalGradeModel.fromJson(Map<String, dynamic> json) =>
      _$FinalGradeModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class GradeListModel {
  final String course;
  final int sks;
  final String grade;
  GradeListModel({
    required this.course,
    required this.sks,
    required this.grade,
  });
  factory GradeListModel.fromJson(Map<String, dynamic> json) =>
      _$GradeListModelFromJson(json);
}

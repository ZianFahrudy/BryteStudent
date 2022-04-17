import 'package:json_annotation/json_annotation.dart';

part 'class_summary_student_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ClassSummaryStudentModel {
  int status;
  String message;
  DataClassSummaryStudentModel data;

  ClassSummaryStudentModel(
      {required this.status, required this.message, required this.data});

  factory ClassSummaryStudentModel.fromJson(Map<String, dynamic> json) =>
      _$ClassSummaryStudentModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DataClassSummaryStudentModel {
  int todayClasses;
  int assignAll;
  int assignTomorrow;
  int assignThisWeek;

  DataClassSummaryStudentModel(
      {required this.todayClasses,
      required this.assignAll,
      required this.assignTomorrow,
      required this.assignThisWeek});

  factory DataClassSummaryStudentModel.fromJson(Map<String, dynamic> json) =>
      _$DataClassSummaryStudentModelFromJson(json);
}

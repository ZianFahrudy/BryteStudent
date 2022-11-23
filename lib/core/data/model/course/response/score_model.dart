import 'package:json_annotation/json_annotation.dart';

part 'score_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class ScoreModel {
  final int status;
  final String message;
  final List<DataScoreModel> data;
  ScoreModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) =>
      _$ScoreModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataScoreModel {
  final String courseName;
  final int sks;
  final String teacherName;
  final String teacherImg;
  final List<StudentScoreModel> studentScore;
  DataScoreModel({
    required this.courseName,
    required this.sks,
    required this.teacherName,
    required this.teacherImg,
    required this.studentScore,
  });

  factory DataScoreModel.fromJson(Map<String, dynamic> json) =>
      _$DataScoreModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class StudentScoreModel {
  final String nim;
  final String name;
  final String ayear;
  final String aperiod;
  final int teachingAssessment;
  final int midSemMarks;
  final int endSemMarks;
  final String finalGrade;
  StudentScoreModel({
    required this.nim,
    required this.name,
    required this.ayear,
    required this.aperiod,
    required this.teachingAssessment,
    required this.midSemMarks,
    required this.endSemMarks,
    required this.finalGrade,
  });

  factory StudentScoreModel.fromJson(Map<String, dynamic> json) =>
      _$StudentScoreModelFromJson(json);
}

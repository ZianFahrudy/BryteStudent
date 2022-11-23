// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreModel _$ScoreModelFromJson(Map<String, dynamic> json) => ScoreModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataScoreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataScoreModel _$DataScoreModelFromJson(Map<String, dynamic> json) =>
    DataScoreModel(
      courseName: json['course_name'] as String,
      sks: json['sks'] as int,
      teacherName: json['teacher_name'] as String,
      teacherImg: json['teacher_img'] as String,
      studentScore: (json['student_score'] as List<dynamic>)
          .map((e) => StudentScoreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

StudentScoreModel _$StudentScoreModelFromJson(Map<String, dynamic> json) =>
    StudentScoreModel(
      nim: json['nim'] as String,
      name: json['name'] as String,
      ayear: json['ayear'] as String,
      aperiod: json['aperiod'] as String,
      teachingAssessment: json['teaching_assessment'] as int,
      midSemMarks: json['mid_sem_marks'] as int,
      endSemMarks: json['end_sem_marks'] as int,
      finalGrade: json['final_grade'] as String,
    );

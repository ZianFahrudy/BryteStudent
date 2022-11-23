// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gpa_grade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GpaGradeModel _$GpaGradeModelFromJson(Map<String, dynamic> json) =>
    GpaGradeModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataGpaGradeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataGpaGradeModel _$DataGpaGradeModelFromJson(Map<String, dynamic> json) =>
    DataGpaGradeModel(
      nim: json['nim'] as String,
      fullname: json['fullname'] as String,
      finalGpa: (json['final_gpa'] as num).toDouble(),
      totSks: json['tot_sks'] as int,
      finalGrade: (json['final_grade'] as List<dynamic>)
          .map((e) => FinalGradeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

FinalGradeModel _$FinalGradeModelFromJson(Map<String, dynamic> json) =>
    FinalGradeModel(
      semester: json['semester'] as String,
      grade: (json['grade'] as List<dynamic>)
          .map((e) => GradeListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

GradeListModel _$GradeListModelFromJson(Map<String, dynamic> json) =>
    GradeListModel(
      course: json['course'] as String,
      sks: json['sks'] as int,
      grade: json['grade'] as String,
    );

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_semester_student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListSemesterStudentModel _$ListSemesterStudentModelFromJson(
        Map<String, dynamic> json) =>
    ListSemesterStudentModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              DataSemesterStudentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataSemesterStudentModel _$DataSemesterStudentModelFromJson(
        Map<String, dynamic> json) =>
    DataSemesterStudentModel(
      nim: json['nim'] as String,
      listSemester: (json['list_semester'] as List<dynamic>)
          .map((e) => SemesterListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SemesterListModel _$SemesterListModelFromJson(Map<String, dynamic> json) =>
    SemesterListModel(
      semester: json['semester'] as String,
      semesterDescp: json['semester_descp'] as String,
    );

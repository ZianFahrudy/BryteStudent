// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataCourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataCourseModel _$DataCourseModelFromJson(Map<String, dynamic> json) =>
    DataCourseModel(
      idCourse: json['idCourse'] as String,
      idUser: json['idUser'] as String,
      course: json['course'] as String,
      teacherName: json['teacher_name'] as String,
      bgColor_1: json['bg_color_1'] as String,
      bgColor_2: json['bg_color_2'] as String,
      textColor_1: json['text_color_1'] as String,
      textColor_2: json['text_color_2'] as String,
      dropShadow: json['drop_shadow'] as String,
    );

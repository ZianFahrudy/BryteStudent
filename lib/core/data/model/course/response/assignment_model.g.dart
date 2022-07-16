// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentModel _$AssignmentModelFromJson(Map<String, dynamic> json) =>
    AssignmentModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataAssignmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataAssignmentModel _$DataAssignmentModelFromJson(Map<String, dynamic> json) =>
    DataAssignmentModel(
      idCourse: json['idCourse'] as String,
      idAssign: json['idAssign'] as String,
      courseName: json['course_name'] as String,
      assignName: json['assign_name'] as String,
      assignDescp: json['assign_descp'] as String,
      assignAllowfrom: json['assign_allowfrom'] as String,
      assignDeadline: json['assign_deadline'] as String,
      assignStatus: json['assign_status'] as String,
      bgColor_1: json['bg_color_1'] as String,
      bgColor_2: json['bg_color_2'] as String,
      textColor_1: json['text_color_1'] as String,
      textColor_2: json['text_color_2'] as String,
      dropShadow: json['drop_shadow'] as String,
    );

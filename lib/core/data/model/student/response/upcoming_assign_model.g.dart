// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_assign_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingAssignModel _$UpcomingAssignModelFromJson(Map<String, dynamic> json) =>
    UpcomingAssignModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              DataUpcomingAssignModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataUpcomingAssignModel _$DataUpcomingAssignModelFromJson(
        Map<String, dynamic> json) =>
    DataUpcomingAssignModel(
      idCourse: json['idCourse'] as String,
      idAssign: json['idAssign'] as String,
      courseName: json['course_name'] as String,
      assignName: json['assign_name'] as String,
      assignDescp: json['assign_descp'] as String,
      assignAllowfrom: json['assign_allowfrom'] as String,
      assignDeadline: json['assign_deadline'] as String,
      assignSession: json['assign_session'] as int,
      assignAttempt: json['assign_attempt'] as bool,
      bgColor1: json['bg_color_1'] as String,
      bgColor2: json['bg_color_2'] as String,
      textColor1: json['text_color_1'] as String,
      textColor2: json['text_color_2'] as String,
      dropShadow: json['drop_shadow'] as String,
    );

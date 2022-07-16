// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_classes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayClassesModel _$TodayClassesModelFromJson(Map<String, dynamic> json) =>
    TodayClassesModel(
      status: json['status'] as int,
      message: json['message'] as String,
      upcomingClasses: json['upcoming_classes'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataTodayClassesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataTodayClassesModel _$DataTodayClassesModelFromJson(
        Map<String, dynamic> json) =>
    DataTodayClassesModel(
      idCourse: json['idCourse'] as String,
      idAttdSes: json['idAttdSes'] as String,
      userid: json['userid'] as String,
      classes: json['classes'] as String,
      sks: json['sks'] as String,
      attdSession: json['attd_session'] as int,
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      status: json['status'] as String,
      bgColor1: json['bg_color_1'] as String,
      bgColor2: json['bg_color_2'] as String,
      textColor1: json['text_color_1'] as String,
      textColor2: json['text_color_2'] as String,
      dropShadow: json['drop_shadow'] as String,
      attdStatusset: json['attd_statusset'] as String,
      attdStatus: json['attd_status'] as String,
      statusset: (json['statusset'] as List<dynamic>)
          .map((e) => StatussetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

StatussetModel _$StatussetModelFromJson(Map<String, dynamic> json) =>
    StatussetModel(
      idStatusset: json['id_statusset'] as String,
      attdCode: json['attd_code'] as String,
      attdDescp: json['attd_descp'] as String,
      attdMaxAllowed: json['attd_max_allowed'] as String,
    );

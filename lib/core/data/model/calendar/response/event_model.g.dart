// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventModel _$CalendarEventModelFromJson(Map<String, dynamic> json) =>
    CalendarEventModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataCalendarEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataCalendarEvent _$DataCalendarEventFromJson(Map<String, dynamic> json) =>
    DataCalendarEvent(
      date: json['date'] as String,
      events: (json['events'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      json['attd_status'] as String?,
      assignDescp: json['assign_descp'] as String?,
      assignName: json['assign_name'] as String?,
      idAssign: json['idAssign'] as String?,
      courseName: json['course_name'] as String?,
      assignAllowfrom: json['assign_allowfrom'] as String?,
      assignDeadline: json['assign_deadline'] as String?,
      assignSession: json['assign_session'] as int?,
      assignAttempt: json['assign_attempt'] as bool?,
      type: json['type'] as String,
      idUser: json['idUser'] as String?,
      idCourse: json['idCourse'] as String?,
      idAttdSes: json['idAttdSes'] as String?,
      classes: json['classes'] as String?,
      sks: json['sks'] as String?,
      attdSession: json['attd_session'] as int?,
      date: json['date'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      status: json['status'] as String?,
      bgColor1: json['bg_color_1'] as String,
      bgColor2: json['bg_color_2'] as String,
      textColor1: json['text_color_1'] as String,
      textColor2: json['text_color_2'] as String,
      dropShadow: json['drop_shadow'] as String,
    );

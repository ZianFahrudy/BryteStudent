// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) =>
    AttendanceModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataAttendanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataAttendanceModel _$DataAttendanceModelFromJson(Map<String, dynamic> json) =>
    DataAttendanceModel(
      courseName: json['course_name'] as String,
      teacherName: json['teacher_name'] as String,
      teacherImg: json['teacher_img'] as String,
      attendanceHead: (json['attendance_head'] as List<dynamic>)
          .map((e) => AttendanceHeadModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      attendanceDetail: (json['attendance_detail'] as List<dynamic>)
          .map((e) => AttendanceDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AttendanceHeadModel _$AttendanceHeadModelFromJson(Map<String, dynamic> json) =>
    AttendanceHeadModel(
      absence: json['absence'] as int,
      attendance: json['attendance'] as String,
    );

AttendanceDetailModel _$AttendanceDetailModelFromJson(
        Map<String, dynamic> json) =>
    AttendanceDetailModel(
      idCourse: json['idCourse'] as String,
      idStudent: json['idStudent'] as String,
      idAttdSes: json['idAttdSes'] as String,
      attdSessDescp: json['attd_sess_descp'] as String,
      attdStartDate: json['attd_start_date'] as String,
      attdEndDate: json['attd_end_date'] as String,
      attdAcronym: json['attd_acronym'] as String,
      attdStatus: json['attd_status'] as String,
      attdStatusset: (json['attd_statusset'] as List<dynamic>)
          .map((e) =>
              AttendanceStatusSetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AttendanceStatusSetModel _$AttendanceStatusSetModelFromJson(
        Map<String, dynamic> json) =>
    AttendanceStatusSetModel(
      idStatusset: json['id_statusset'] as String,
      attdCode: json['attd_code'] as String,
      attdDescp: json['attd_descp'] as String,
      attdMaxAllowed: json['attd_max_allowed'] as String,
    );

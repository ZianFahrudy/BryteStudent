// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_rate_student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceRateStudentModel _$AttendanceRateStudentModelFromJson(
        Map<String, dynamic> json) =>
    AttendanceRateStudentModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataAttendanceRateStudentModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

DataAttendanceRateStudentModel _$DataAttendanceRateStudentModelFromJson(
        Map<String, dynamic> json) =>
    DataAttendanceRateStudentModel(
      periodDescp: json['period_descp'] as String?,
      attdRate: (json['attd_rate'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      academicPeriod: json['academic_period'] as String?,
      attendance: (json['attendance'] as List<dynamic>?)
          ?.map((e) =>
              AttendanceDetailStudentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AttendanceDetailStudentModel _$AttendanceDetailStudentModelFromJson(
        Map<String, dynamic> json) =>
    AttendanceDetailStudentModel(
      currentAttdRate: json['current_attd_rate'] as String,
      currentSksTot: json['current_sks_tot'] as int,
      details: (json['details'] as List<dynamic>)
          .map((e) => DetailAttendanceRateStudentModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

DetailAttendanceRateStudentModel _$DetailAttendanceRateStudentModelFromJson(
        Map<String, dynamic> json) =>
    DetailAttendanceRateStudentModel(
      courseName: json['course_name'] as String,
      sks: json['sks'] as String,
      attdRate: json['attd_rate'] as String,
    );

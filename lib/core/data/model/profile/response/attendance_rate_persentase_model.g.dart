// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_rate_persentase_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceRatePersentaseModel _$AttendanceRatePersentaseModelFromJson(
        Map<String, dynamic> json) =>
    AttendanceRatePersentaseModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataAttendanceRatePersentaseModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

DataAttendanceRatePersentaseModel _$DataAttendanceRatePersentaseModelFromJson(
        Map<String, dynamic> json) =>
    DataAttendanceRatePersentaseModel(
      attdRate:
          (json['attd_rate'] as List<dynamic>).map((e) => e as String).toList(),
    );

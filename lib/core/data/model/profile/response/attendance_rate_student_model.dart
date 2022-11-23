import 'package:json_annotation/json_annotation.dart';

part 'attendance_rate_student_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class AttendanceRateStudentModel {
  final int status;
  final String message;
  final List<DataAttendanceRateStudentModel> data;
  AttendanceRateStudentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AttendanceRateStudentModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRateStudentModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DataAttendanceRateStudentModel {
  final String? academicPeriod;
  final List<String>? attdRate;
  final String? periodDescp;
  final List<AttendanceDetailStudentModel>? attendance;
  DataAttendanceRateStudentModel({
    this.periodDescp,
    this.attdRate,
    this.academicPeriod,
    this.attendance,
  });
  factory DataAttendanceRateStudentModel.fromJson(Map<String, dynamic> json) =>
      _$DataAttendanceRateStudentModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class AttendanceDetailStudentModel {
  final String currentAttdRate;
  final int currentSksTot;
  final List<DetailAttendanceRateStudentModel> details;
  AttendanceDetailStudentModel({
    required this.currentAttdRate,
    required this.currentSksTot,
    required this.details,
  });

  factory AttendanceDetailStudentModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDetailStudentModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DetailAttendanceRateStudentModel {
  final String courseName;
  final String sks;
  final String attdRate;
  DetailAttendanceRateStudentModel({
    required this.courseName,
    required this.sks,
    required this.attdRate,
  });

  factory DetailAttendanceRateStudentModel.fromJson(
          Map<String, dynamic> json) =>
      _$DetailAttendanceRateStudentModelFromJson(json);
}

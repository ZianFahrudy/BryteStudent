import 'package:json_annotation/json_annotation.dart';

part 'moodle_attendance_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class MoodleAttendanceModel {
  final int status;
  final String message;
  final int upcomingClasses;
  final List<DataMoodleAttendance> data;
  MoodleAttendanceModel(
      {required this.status,
      required this.message,
      required this.upcomingClasses,
      required this.data});

  factory MoodleAttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$MoodleAttendanceModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DataMoodleAttendance {
  @JsonKey(name: 'idCourse')
  final String idCourse;
  @JsonKey(name: 'idAttdSes')
  final String idAttdSes;
  final String userid;
  final String classes;
  final String sks;
  final int attdSession;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  @JsonKey(name: 'bg_color_1')
  final String bgColor1;
  @JsonKey(name: 'bg_color_2')
  final String bgColor2;
  @JsonKey(name: 'text_color_1')
  final String textColor1;
  @JsonKey(name: 'text_color_2')
  final String textColor2;
  final String dropShadow;
  final String attdStatusset;
  final List<StatussetDataMoodleAttendance> statusset;
  DataMoodleAttendance({
    required this.idCourse,
    required this.idAttdSes,
    required this.userid,
    required this.classes,
    required this.sks,
    required this.attdSession,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.bgColor1,
    required this.bgColor2,
    required this.textColor1,
    required this.textColor2,
    required this.dropShadow,
    required this.attdStatusset,
    required this.statusset,
  });

  factory DataMoodleAttendance.fromJson(Map<String, dynamic> json) =>
      _$DataMoodleAttendanceFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class StatussetDataMoodleAttendance {
  final String idStatusset;
  final String attdCode;
  final String attdDescp;
  final String attdMaxAllowed;
  StatussetDataMoodleAttendance({
    required this.idStatusset,
    required this.attdCode,
    required this.attdDescp,
    required this.attdMaxAllowed,
  });

  factory StatussetDataMoodleAttendance.fromJson(Map<String, dynamic> json) =>
      _$StatussetDataMoodleAttendanceFromJson(json);
}

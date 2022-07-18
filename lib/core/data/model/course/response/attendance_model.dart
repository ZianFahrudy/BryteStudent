import 'package:json_annotation/json_annotation.dart';

part 'attendance_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class AttendanceModel {
  final int status;
  final String message;
  final List<DataAttendanceModel> data;
  AttendanceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataAttendanceModel {
  final String courseName;
  final String teacherName;
  final String teacherImg;
  final List<AttendanceHeadModel> attendanceHead;
  final List<AttendanceDetailModel> attendanceDetail;
  DataAttendanceModel({
    required this.courseName,
    required this.teacherName,
    required this.teacherImg,
    required this.attendanceHead,
    required this.attendanceDetail,
  });

  factory DataAttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$DataAttendanceModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class AttendanceHeadModel {
  final int absence;
  final String attendance;
  AttendanceHeadModel({
    required this.absence,
    required this.attendance,
  });

  factory AttendanceHeadModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceHeadModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class AttendanceDetailModel {
  @JsonKey(name: 'idCourse')
  final String idCourse;
  @JsonKey(name: 'idStudent')
  final String idStudent;
  @JsonKey(name: 'idAttdSes')
  final String idAttdSes;
  final String attdSessDescp;
  final String attdStartDate;
  final String attdEndDate;
  final String attdAcronym;
  final String attdStatus;
  final List<AttendanceStatusSetModel> attdStatusset;
  AttendanceDetailModel({
    required this.idCourse,
    required this.idStudent,
    required this.idAttdSes,
    required this.attdSessDescp,
    required this.attdStartDate,
    required this.attdEndDate,
    required this.attdAcronym,
    required this.attdStatus,
    required this.attdStatusset,
  });

  factory AttendanceDetailModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDetailModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class AttendanceStatusSetModel {
  final String idStatusset;
  final String attdCode;
  final String attdDescp;
  final String attdMaxAllowed;
  AttendanceStatusSetModel({
    required this.idStatusset,
    required this.attdCode,
    required this.attdDescp,
    required this.attdMaxAllowed,
  });

  factory AttendanceStatusSetModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceStatusSetModelFromJson(json);
}

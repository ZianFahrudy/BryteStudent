import 'package:json_annotation/json_annotation.dart';

part 'attendance_rate_persentase_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class AttendanceRatePersentaseModel {
  final int status;
  final String message;
  final List<DataAttendanceRatePersentaseModel> data;
  AttendanceRatePersentaseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AttendanceRatePersentaseModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRatePersentaseModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DataAttendanceRatePersentaseModel {
  final List<String> attdRate;
  DataAttendanceRatePersentaseModel({
    required this.attdRate,
  });

  factory DataAttendanceRatePersentaseModel.fromJson(
          Map<String, dynamic> json) =>
      _$DataAttendanceRatePersentaseModelFromJson(json);
}

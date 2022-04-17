import 'package:json_annotation/json_annotation.dart';

part 'upcoming_assign_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class UpcomingAssignModel {
  final int status;
  final String message;
  final List<DataUpcomingAssignModel> data;
  UpcomingAssignModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpcomingAssignModel.fromJson(Map<String, dynamic> json) =>
      _$UpcomingAssignModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DataUpcomingAssignModel {
  @JsonKey(name: 'idCourse')
  final String idCourse;
  @JsonKey(name: 'idAssign')
  final String idAssign;
  final String courseName;
  final String assignName;
  final String assignDescp;
  final String assignAllowfrom;
  final String assignDeadline;
  final int assignSession;
  final bool assignAttempt;
  @JsonKey(name: 'bg_color_1')
  final String bgColor1;
  @JsonKey(name: 'bg_color_2')
  final String bgColor2;
  @JsonKey(name: 'text_color_1')
  final String textColor1;
  @JsonKey(name: 'text_color_2')
  final String textColor2;
  final String dropShadow;
  DataUpcomingAssignModel({
    required this.idCourse,
    required this.idAssign,
    required this.courseName,
    required this.assignName,
    required this.assignDescp,
    required this.assignAllowfrom,
    required this.assignDeadline,
    required this.assignSession,
    required this.assignAttempt,
    required this.bgColor1,
    required this.bgColor2,
    required this.textColor1,
    required this.textColor2,
    required this.dropShadow,
  });

  factory DataUpcomingAssignModel.fromJson(Map<String, dynamic> json) =>
      _$DataUpcomingAssignModelFromJson(json);
}

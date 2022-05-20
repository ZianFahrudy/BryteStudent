import 'package:json_annotation/json_annotation.dart';

part 'upcoming_assign_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class UpcomingAssignModel {
  int status;
  String message;
  List<DataUpcomingAssignModel> data;
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
  String idCourse;
  @JsonKey(name: 'idAssign')
  String idAssign;
  String courseName;
  String assignName;
  String assignDescp;
  String assignAllowfrom;
  String assignDeadline;
  int assignSession;
  bool assignAttempt;
  @JsonKey(name: 'bg_color_1')
  String bgColor1;
  @JsonKey(name: 'bg_color_2')
  String bgColor2;
  @JsonKey(name: 'text_color_1')
  String textColor1;
  @JsonKey(name: 'text_color_2')
  String textColor2;
  String dropShadow;
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

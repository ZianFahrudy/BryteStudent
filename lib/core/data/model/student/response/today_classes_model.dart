import 'package:json_annotation/json_annotation.dart';

part 'today_classes_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class TodayClassesModel {
  int status;
  String message;
  int upcomingClasses;
  List<DataTodayClassesModel> data;

  TodayClassesModel(
      {required this.status,
      required this.message,
      required this.upcomingClasses,
      required this.data});

  factory TodayClassesModel.fromJson(Map<String, dynamic> json) =>
      _$TodayClassesModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DataTodayClassesModel {
  @JsonKey(name: 'idCourse')
  String idCourse;
  @JsonKey(name: 'idAttdSes')
  String idAttdSes;
  String userid;
  String classes;
  String sks;
  int attdSession;
  String date;
  String startTime;
  String endTime;
  String status;
  @JsonKey(name: 'bg_color_1')
  String bgColor1;
  @JsonKey(name: 'bg_color_2')
  String bgColor2;
  @JsonKey(name: 'text_color_1')
  String textColor1;
  @JsonKey(name: 'text_color_2')
  String textColor2;
  String dropShadow;
  String attdStatusset;
  List<StatussetModel> statusset;

  DataTodayClassesModel(
      {required this.idCourse,
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
      required this.statusset});

  factory DataTodayClassesModel.fromJson(Map<String, dynamic> json) =>
      _$DataTodayClassesModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class StatussetModel {
  String idStatusset;
  String attdCode;
  String attdDescp;
  String attdMaxAllowed;

  StatussetModel(
      {required this.idStatusset,
      required this.attdCode,
      required this.attdDescp,
      required this.attdMaxAllowed});

  factory StatussetModel.fromJson(Map<String, dynamic> json) =>
      _$StatussetModelFromJson(json);
}

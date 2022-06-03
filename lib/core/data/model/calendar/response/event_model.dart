import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class CalendarEventModel {
  const CalendarEventModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final int status;
  final String message;
  final List<DataCalendarEvent> data;

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DataCalendarEvent {
  const DataCalendarEvent({
    required this.date,
    required this.events,
  });

  final String date;
  final List<Event> events;

  factory DataCalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$DataCalendarEventFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class Event {
  const Event(
    this.attdStatus, {
    this.assignDescp,
    this.assignName,
    this.idAssign,
    this.courseName,
    this.assignAllowfrom,
    this.assignDeadline,
    this.assignSession,
    this.assignAttempt,
    required this.type,
    this.idUser,
    this.idCourse,
    this.idAttdSes,
    this.classes,
    this.sks,
    this.attdSession,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
    required this.bgColor1,
    required this.bgColor2,
    required this.textColor1,
    required this.textColor2,
    required this.dropShadow,
  });
  @JsonKey(name: 'idAssign')
  final String? idAssign;
  final String? courseName;
  final String? assignName;
  final String? assignDescp;
  final String? assignAllowfrom;
  final String? assignDeadline;
  final int? assignSession;
  final bool? assignAttempt;
  final String type;
  @JsonKey(name: 'idUser')
  final String? idUser;
  @JsonKey(name: 'idCourse')
  final String? idCourse;
  @JsonKey(name: 'idAttdSes')
  final String? idAttdSes;
  final String? classes;
  final String? sks;
  final int? attdSession;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? status;
  @JsonKey(name: 'bg_color_1')
  final String bgColor1;
  @JsonKey(name: 'bg_color_2')
  final String bgColor2;
  @JsonKey(name: 'text_color_1')
  final String textColor1;
  @JsonKey(name: 'text_color_2')
  final String textColor2;
  final String dropShadow;
  final String? attdStatus;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';

part 'announcement_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class AnnouncementModel {
  int status;
  String message;
  List<DataAnnouncementModel> data;

  AnnouncementModel(
      {required this.status, required this.message, required this.data});

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DataAnnouncementModel {
  int announNumb;
  String announDate;
  String announAuthor;
  String profileimageurl;
  String roleDescp;
  String announSubject;
  String announMsg;

  DataAnnouncementModel(
      {required this.announNumb,
      required this.announDate,
      required this.announAuthor,
      required this.profileimageurl,
      required this.roleDescp,
      required this.announSubject,
      required this.announMsg});

  factory DataAnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$DataAnnouncementModelFromJson(json);
}

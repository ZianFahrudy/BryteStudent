import 'package:json_annotation/json_annotation.dart';

part 'participant_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class ParticipantModel {
  final int status;
  final String message;
  final List<DataParticipantModel> data;
  ParticipantModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataParticipantModel {
  @JsonKey(name: 'idCourse')
  final String idCourse;
  @JsonKey(name: 'idUser')
  final String idUser;
  final String course;
  final String teacher;
  final int totParticipant;
  final int totPage;
  final int perPage;
  final int currentPage;
  final int currentParticipant;
  final int loadedParticipant;
  final List<DataListParticipantModel> participant;
  DataParticipantModel({
    required this.idCourse,
    required this.idUser,
    required this.course,
    required this.teacher,
    required this.totParticipant,
    required this.totPage,
    required this.perPage,
    required this.currentPage,
    required this.currentParticipant,
    required this.loadedParticipant,
    required this.participant,
  });

  factory DataParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$DataParticipantModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataListParticipantModel {
  @JsonKey(name: 'idUser')
  final String idUser;
  final String name;
  final String nim;
  final String img;
  DataListParticipantModel({
    required this.idUser,
    required this.name,
    required this.nim,
    required this.img,
  });

  factory DataListParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$DataListParticipantModelFromJson(json);
}

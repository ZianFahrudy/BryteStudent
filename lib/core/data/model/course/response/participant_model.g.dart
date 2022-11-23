// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantModel _$ParticipantModelFromJson(Map<String, dynamic> json) =>
    ParticipantModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataParticipantModel _$DataParticipantModelFromJson(
        Map<String, dynamic> json) =>
    DataParticipantModel(
      idCourse: json['idCourse'] as String,
      idUser: json['idUser'] as String,
      course: json['course'] as String,
      teacher: json['teacher'] as String,
      totParticipant: json['tot_participant'] as int,
      totPage: json['tot_page'] as int,
      perPage: json['per_page'] as int,
      currentPage: json['current_page'] as int,
      currentParticipant: json['current_participant'] as int,
      loadedParticipant: json['loaded_participant'] as int,
      participant: (json['participant'] as List<dynamic>)
          .map((e) =>
              DataListParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataListParticipantModel _$DataListParticipantModelFromJson(
        Map<String, dynamic> json) =>
    DataListParticipantModel(
      idUser: json['idUser'] as String,
      name: json['name'] as String,
      nim: json['nim'] as String,
      img: json['img'] as String,
    );

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementModel _$AnnouncementModelFromJson(Map<String, dynamic> json) =>
    AnnouncementModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataAnnouncementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataAnnouncementModel _$DataAnnouncementModelFromJson(
        Map<String, dynamic> json) =>
    DataAnnouncementModel(
      announNumb: json['announ_numb'] as int,
      announDate: json['announ_date'] as String,
      announAuthor: json['announ_author'] as String,
      profileimageurl: json['profileimageurl'] as String,
      roleDescp: json['role_descp'] as String,
      announSubject: json['announ_subject'] as String,
      announMsg: json['announ_msg'] as String,
    );

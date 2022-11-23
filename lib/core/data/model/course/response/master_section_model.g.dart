// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterSectionModel _$MasterSectionModelFromJson(Map<String, dynamic> json) =>
    MasterSectionModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map(
              (e) => DataMasterSectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataMasterSectionModel _$DataMasterSectionModelFromJson(
        Map<String, dynamic> json) =>
    DataMasterSectionModel(
      id: json['id'] as int,
      sectionNo: json['section_no'] as int,
      sectionName: json['section_name'] as String?,
    );

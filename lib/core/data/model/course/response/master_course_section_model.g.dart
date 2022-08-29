// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_course_section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterCourseSectionModel _$MasterCourseSectionModelFromJson(
        Map<String, dynamic> json) =>
    MasterCourseSectionModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              DataMasterCourseSectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataMasterCourseSectionModel _$DataMasterCourseSectionModelFromJson(
        Map<String, dynamic> json) =>
    DataMasterCourseSectionModel(
      id: json['id'] as int,
      sectionNo: json['section_no'] as int,
      sectionName: json['section_name'] as String,
    );

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_general_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseGeneralModel _$CourseGeneralModelFromJson(Map<String, dynamic> json) =>
    CourseGeneralModel(
      json['id'] as int,
      json['name'] as String,
      json['visible'] as int,
      json['summary'] as String,
      json['summaryformat'] as int,
      json['section'] as int,
      json['hiddenbynumsections'] as int,
      json['uservisible'] as bool,
      (json['modules'] as List<dynamic>)
          .map((e) =>
              CourseGeneralModulesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

CourseGeneralModulesModel _$CourseGeneralModulesModelFromJson(
        Map<String, dynamic> json) =>
    CourseGeneralModulesModel(
      id: json['id'] as int,
      url: json['url'] as String,
      description: json['description'] as String?,
      name: json['name'] as String,
      instance: json['instance'] as int,
      visible: json['visible'] as int,
      uservisible: json['uservisible'] as bool,
      visibleoncoursepage: json['visibleoncoursepage'] as int,
      modicon: json['modicon'] as String,
      modname: json['modname'] as String,
      modplural: json['modplural'] as String,
      indent: json['indent'] as int,
      onclick: json['onclick'] as String,
      afterlink: json['afterlink'] as String?,
      customdata: json['customdata'] as String,
      noviewlink: json['noviewlink'] as bool,
      completion: json['completion'] as int,
      contents: (json['contents'] as List<dynamic>?)
          ?.map((e) =>
              DataContentsCourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataContentsCourseModel _$DataContentsCourseModelFromJson(
        Map<String, dynamic> json) =>
    DataContentsCourseModel(
      type: json['type'] as String,
      mimetype: json['mimetype'] as String?,
    );

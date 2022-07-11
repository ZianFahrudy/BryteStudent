import 'package:json_annotation/json_annotation.dart';

part 'course_general_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class CourseGeneralModel {
  CourseGeneralModel(
    this.id,
    this.name,
    this.visible,
    this.summary,
    this.summaryformat,
    this.section,
    this.hiddenbynumsections,
    this.uservisible,
    this.modules,
  );
  final int id;
  final String name;
  final int visible;
  final String summary;
  final int summaryformat;
  final int section;
  final int hiddenbynumsections;
  final bool uservisible;
  final List<CourseGeneralModulesModel> modules;

  factory CourseGeneralModel.fromJson(Map<String, dynamic> json) =>
      _$CourseGeneralModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class CourseGeneralModulesModel {
  final int id;
  final String url;
  final String name;
  final int instance;
  final int visible;
  final String? description;
  final bool uservisible;
  final int visibleoncoursepage;
  final String modicon;
  final String modname;
  final String modplural;
  final int indent;
  final String onclick;
  final String? afterlink;
  final String customdata;
  final bool noviewlink;
  final int completion;
  final List<DataContentsCourseModel>? contents;

  CourseGeneralModulesModel({
    required this.id,
    required this.url,
    this.description,
    required this.name,
    required this.instance,
    required this.visible,
    required this.uservisible,
    required this.visibleoncoursepage,
    required this.modicon,
    required this.modname,
    required this.modplural,
    required this.indent,
    required this.onclick,
    this.afterlink,
    required this.customdata,
    required this.noviewlink,
    required this.completion,
    this.contents,
  });

  factory CourseGeneralModulesModel.fromJson(Map<String, dynamic> json) =>
      _$CourseGeneralModulesModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataContentsCourseModel {
  final String type;
  final String? mimetype;
  DataContentsCourseModel({
    required this.type,
    this.mimetype,
  });
  factory DataContentsCourseModel.fromJson(Map<String, dynamic> json) =>
      _$DataContentsCourseModelFromJson(json);
}

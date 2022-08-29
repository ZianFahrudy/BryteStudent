import 'package:json_annotation/json_annotation.dart';

part 'master_course_section_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class MasterCourseSectionModel {
  final int status;
  final String message;
  final List<DataMasterCourseSectionModel> data;
  MasterCourseSectionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MasterCourseSectionModel.fromJson(Map<String, dynamic> json) =>
      _$MasterCourseSectionModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataMasterCourseSectionModel {
  final int id;
  final int sectionNo;
  final String sectionName;
  DataMasterCourseSectionModel({
    required this.id,
    required this.sectionNo,
    required this.sectionName,
  });
  factory DataMasterCourseSectionModel.fromJson(Map<String, dynamic> json) =>
      _$DataMasterCourseSectionModelFromJson(json);
}

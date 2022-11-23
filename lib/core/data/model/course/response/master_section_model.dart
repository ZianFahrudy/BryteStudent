import 'package:json_annotation/json_annotation.dart';

part 'master_section_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class MasterSectionModel {
  final int status;
  final String message;
  final List<DataMasterSectionModel> data;
  MasterSectionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MasterSectionModel.fromJson(Map<String, dynamic> json) =>
      _$MasterSectionModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataMasterSectionModel {
  final int id;
  final int sectionNo;
  final String? sectionName;
  DataMasterSectionModel({
    required this.id,
    required this.sectionNo,
    this.sectionName,
  });

  factory DataMasterSectionModel.fromJson(Map<String, dynamic> json) =>
      _$DataMasterSectionModelFromJson(json);
}

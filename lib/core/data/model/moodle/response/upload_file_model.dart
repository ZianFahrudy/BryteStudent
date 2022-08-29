import 'package:json_annotation/json_annotation.dart';

part 'upload_file_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class UploadFileModel {
  final String component;
  final int contextid;
  final String userid;
  final String filearea;
  final String filename;
  final String filepath;
  final int itemid;
  final String license;
  final String author;
  final String source;
  UploadFileModel({
    required this.component,
    required this.contextid,
    required this.userid,
    required this.filearea,
    required this.filename,
    required this.filepath,
    required this.itemid,
    required this.license,
    required this.author,
    required this.source,
  });

  factory UploadFileModel.fromJson(Map<String, dynamic> json) =>
      _$UploadFileModelFromJson(json);
}

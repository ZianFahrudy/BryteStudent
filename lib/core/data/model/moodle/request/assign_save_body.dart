import 'package:json_annotation/json_annotation.dart';

part 'assign_save_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class AssignSaveBody {
  final String wstoken;
  final String wsfunction;
  final String moodlewsrestformat;
  final int assignmentid;
  @JsonKey(name: 'plugindata[onlinetext_editor][text]')
  final String plugindataText;
  @JsonKey(name: 'plugindata[onlinetext_editor][format]')
  final int plugindataFormat;
  @JsonKey(name: 'plugindata[onlinetext_editor][itemid]')
  final int plugindataItemId;
  @JsonKey(name: 'plugindata[files_filemanager]')
  final int plugindataFilesManager;
  AssignSaveBody({
    required this.wstoken,
    required this.wsfunction,
    required this.moodlewsrestformat,
    required this.assignmentid,
    required this.plugindataText,
    required this.plugindataFormat,
    required this.plugindataItemId,
    required this.plugindataFilesManager,
  });

  Map<String, dynamic> toJson() => _$AssignSaveBodyToJson(this);
}

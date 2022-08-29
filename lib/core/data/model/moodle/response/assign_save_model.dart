import 'package:json_annotation/json_annotation.dart';

part 'assign_save_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class AssignSaveModel {
  final String item;
  final int itemid;
  final String warningcode;
  final String message;
  AssignSaveModel({
    required this.item,
    required this.itemid,
    required this.warningcode,
    required this.message,
  });

  factory AssignSaveModel.fromJson(Map<String, dynamic> json) =>
      _$AssignSaveModelFromJson(json);
}

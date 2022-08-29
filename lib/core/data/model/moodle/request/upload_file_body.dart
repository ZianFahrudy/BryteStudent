import 'package:json_annotation/json_annotation.dart';

part 'upload_file_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class UploadFileBody {
  final String token;
  final String filearea;
  final int itemid;
  final String file;

  UploadFileBody({
    required this.token,
    required this.filearea,
    required this.itemid,
    required this.file,
  });

  Map<String, dynamic> toJson() => _$UploadFileBodyToJson(this);
}

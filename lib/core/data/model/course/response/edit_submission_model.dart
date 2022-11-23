import 'package:json_annotation/json_annotation.dart';

part 'edit_submission_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class EditSubmissionModel {
  final LastAttemptModel? lastattempt;
  final String? exception;
  final String? message;
  EditSubmissionModel({
    this.lastattempt,
    this.exception,
    this.message,
  });

  factory EditSubmissionModel.fromJson(Map<String, dynamic> json) =>
      _$EditSubmissionModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class LastAttemptModel {
  final SubmissionModel submission;
  final bool submissionsenabled;
  final bool locked;
  final bool graded;
  final bool canedit;
  final bool caneditowner;
  final bool cansubmit;
  // final String? extensionduedate;
  final bool blindmarking;
  final String gradingstatus;
  LastAttemptModel({
    required this.submission,
    required this.submissionsenabled,
    required this.locked,
    required this.graded,
    required this.canedit,
    required this.caneditowner,
    required this.cansubmit,
    // this.extensionduedate,
    required this.blindmarking,
    required this.gradingstatus,
  });

  factory LastAttemptModel.fromJson(Map<String, dynamic> json) =>
      _$LastAttemptModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class SubmissionModel {
  final int id;
  final int userid;
  final int attemptnumber;
  final int timecreated;
  final int timemodified;
  final String status;
  final int groupid;
  final int assignment;
  final int latest;
  final List<PluginsModel> plugins;
  SubmissionModel({
    required this.id,
    required this.userid,
    required this.attemptnumber,
    required this.timecreated,
    required this.timemodified,
    required this.status,
    required this.groupid,
    required this.assignment,
    required this.latest,
    required this.plugins,
  });

  factory SubmissionModel.fromJson(Map<String, dynamic> json) =>
      _$SubmissionModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class PluginsModel {
  final String type;
  final String name;
  final List<FileAreasModel>? fileareas;
  PluginsModel({
    required this.type,
    required this.name,
    this.fileareas,
  });

  factory PluginsModel.fromJson(Map<String, dynamic> json) =>
      _$PluginsModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class FileAreasModel {
  final String area;
  final List<FilesModel> files;
  FileAreasModel({
    required this.area,
    required this.files,
  });

  factory FileAreasModel.fromJson(Map<String, dynamic> json) =>
      _$FileAreasModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class FilesModel {
  final String filename;
  final String filepath;
  final int filesize;
  final String fileurl;
  final int timemodified;
  final String mimetype;
  final bool isexternalfile;
  FilesModel({
    required this.filename,
    required this.filepath,
    required this.filesize,
    required this.fileurl,
    required this.timemodified,
    required this.mimetype,
    required this.isexternalfile,
  });

  factory FilesModel.fromJson(Map<String, dynamic> json) =>
      _$FilesModelFromJson(json);
}

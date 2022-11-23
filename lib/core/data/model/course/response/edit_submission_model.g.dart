// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_submission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditSubmissionModel _$EditSubmissionModelFromJson(Map<String, dynamic> json) =>
    EditSubmissionModel(
      lastattempt: json['lastattempt'] == null
          ? null
          : LastAttemptModel.fromJson(
              json['lastattempt'] as Map<String, dynamic>),
      exception: json['exception'] as String?,
      message: json['message'] as String?,
    );

LastAttemptModel _$LastAttemptModelFromJson(Map<String, dynamic> json) =>
    LastAttemptModel(
      submission:
          SubmissionModel.fromJson(json['submission'] as Map<String, dynamic>),
      submissionsenabled: json['submissionsenabled'] as bool,
      locked: json['locked'] as bool,
      graded: json['graded'] as bool,
      canedit: json['canedit'] as bool,
      caneditowner: json['caneditowner'] as bool,
      cansubmit: json['cansubmit'] as bool,
      blindmarking: json['blindmarking'] as bool,
      gradingstatus: json['gradingstatus'] as String,
    );

SubmissionModel _$SubmissionModelFromJson(Map<String, dynamic> json) =>
    SubmissionModel(
      id: json['id'] as int,
      userid: json['userid'] as int,
      attemptnumber: json['attemptnumber'] as int,
      timecreated: json['timecreated'] as int,
      timemodified: json['timemodified'] as int,
      status: json['status'] as String,
      groupid: json['groupid'] as int,
      assignment: json['assignment'] as int,
      latest: json['latest'] as int,
      plugins: (json['plugins'] as List<dynamic>)
          .map((e) => PluginsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

PluginsModel _$PluginsModelFromJson(Map<String, dynamic> json) => PluginsModel(
      type: json['type'] as String,
      name: json['name'] as String,
      fileareas: (json['fileareas'] as List<dynamic>?)
          ?.map((e) => FileAreasModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

FileAreasModel _$FileAreasModelFromJson(Map<String, dynamic> json) =>
    FileAreasModel(
      area: json['area'] as String,
      files: (json['files'] as List<dynamic>)
          .map((e) => FilesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

FilesModel _$FilesModelFromJson(Map<String, dynamic> json) => FilesModel(
      filename: json['filename'] as String,
      filepath: json['filepath'] as String,
      filesize: json['filesize'] as int,
      fileurl: json['fileurl'] as String,
      timemodified: json['timemodified'] as int,
      mimetype: json['mimetype'] as String,
      isexternalfile: json['isexternalfile'] as bool,
    );

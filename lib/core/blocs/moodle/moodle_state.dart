part of 'moodle_bloc.dart';

@immutable
abstract class MoodleState {}

class MoodleInitial extends MoodleState {}

class MoodleLoading extends MoodleState {}

class UploadFileSuccess extends MoodleState {
  final UploadFileModel response;

  UploadFileSuccess({
    required this.response,
  });
}

class MoodleFailure extends MoodleState {
  final String msg;

  MoodleFailure({
    required this.msg,
  });
}

class AssignSaveFileSuccess extends MoodleState {
  final List<AssignSaveModel> response;
  AssignSaveFileSuccess({
    required this.response,
  });
}

class AssignSaveFailure extends MoodleState {
  final String msg;

  AssignSaveFailure({
    required this.msg,
  });
}

class AssignSubmitFileSuccess extends MoodleState {
  final List<AssignSaveModel> response;
  AssignSubmitFileSuccess({
    required this.response,
  });
}

class AssignSubmitFailure extends MoodleState {
  final String msg;

  AssignSubmitFailure({
    required this.msg,
  });
}

class EditSubmissionSuccess extends MoodleState {}

class EditSubmissionFailure extends MoodleState {}

class EditSubmissionLoading extends MoodleState {}

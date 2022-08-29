part of 'moodle_bloc.dart';

@immutable
abstract class MoodleEvent {}

class UploadFileEvent extends MoodleEvent {
  final UploadFileBody body;

  UploadFileEvent({
    required this.body,
  });
}

class AssignSaveEvent extends MoodleEvent {
  final AssignSaveBody body;
  final AssignSaveJsonBody jsonBody;
  AssignSaveEvent({
    required this.body,
    required this.jsonBody,
  });
}

class AssignSubmitEvent extends MoodleEvent {
  final AssignSubmitFileBody body;
  final AssignSaveJsonBody jsonBody;
  AssignSubmitEvent({
    required this.body,
    required this.jsonBody,
  });
}

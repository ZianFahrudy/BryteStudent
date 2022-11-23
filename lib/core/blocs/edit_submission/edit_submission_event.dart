part of 'edit_submission_bloc.dart';

@immutable
abstract class EditSubmissionEvent {}

class GetEditSubmissionEvent extends EditSubmissionEvent {
  final EditSubmissionBody body;
  GetEditSubmissionEvent({
    required this.body,
  });
}

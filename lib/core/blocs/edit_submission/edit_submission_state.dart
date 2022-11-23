part of 'edit_submission_bloc.dart';

@immutable
abstract class EditSubmissionState {}

class EditSubmissionInitial extends EditSubmissionState {}

class EditSubmissionLoading extends EditSubmissionState {}

class EditSubmissionSuccess extends EditSubmissionState {
  final EditSubmissionModel response;
  EditSubmissionSuccess({
    required this.response,
  });
}

class EditSubmissionFailure extends EditSubmissionState {
  final String msg;
  EditSubmissionFailure({
    required this.msg,
  });
}

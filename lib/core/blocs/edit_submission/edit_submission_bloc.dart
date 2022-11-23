import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/course/request/edit_submission_body.dart';
import 'package:bryte/core/data/model/course/response/edit_submission_model.dart';
import 'package:bryte/core/repo/course/course_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'edit_submission_event.dart';
part 'edit_submission_state.dart';

@injectable
class EditSubmissionBloc
    extends Bloc<EditSubmissionEvent, EditSubmissionState> {
  CourseRepository apiRepository;

  EditSubmissionBloc(this.apiRepository) : super(EditSubmissionInitial()) {
    on<GetEditSubmissionEvent>((event, emit) async {
      try {
        emit(EditSubmissionLoading());
        final data = await apiRepository.getEditSubmission(event.body);

        if (data.lastattempt != null) {
          emit(EditSubmissionSuccess(response: data));
        } else if (data.exception != null) {
          emit(EditSubmissionFailure(msg: data.message!));
        } else {
          emit(EditSubmissionFailure(msg: 'ada error'));
        }
      } catch (e) {
        emit(EditSubmissionFailure(msg: e.toString()));
      }
    });
  }
}

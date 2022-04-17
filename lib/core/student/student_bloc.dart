import 'package:bloc/bloc.dart';
import 'package:bryte/core/model/student/request/announcement_body.dart';
import 'package:bryte/core/model/student/response/announcement_model.dart';
import 'package:bryte/core/repo/student/student_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'student_event.dart';
part 'student_state.dart';

@injectable
class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentRepository apiRepository;

  StudentBloc(this.apiRepository) : super(ClassSummaryStudentInitial()) {
    on<GetAnnouncementEvent>((event, emit) async {
      try {
        emit(AnnouncementLoading());
        final data = await apiRepository.getAnnouncement(event.body);
        if (data.status == 200) {
          emit(AnnouncementSuccess(response: data));
        } else if (data.status == 404) {
          emit(AnnouncementFailure(data.message));
        }
      } catch (e) {
        emit(AnnouncementFailure(e.toString()));
      }
    });
  }
}

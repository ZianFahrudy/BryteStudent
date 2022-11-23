import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/profile/request/list_semester_student_body.dart';
import 'package:bryte/core/data/model/profile/response/list_semester_student_model.dart';
import 'package:bryte/core/repo/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'list_semester_student_event.dart';
part 'list_semester_student_state.dart';

@injectable
class ListSemesterStudentBloc
    extends Bloc<ListSemesterStudentEvent, ListSemesterStudentState> {
  ProfileRepository apiRepository;
  ListSemesterStudentBloc(this.apiRepository)
      : super(ListSemesterStudentInitial()) {
    on<GetListSemesterStudentEvent>((event, emit) async {
      try {
        emit(ListSemesterStudentLoading());
        final data = await apiRepository.getListSemesterStudent(event.body);
        if (data.status == 200) {
          emit(ListSemesterStudentSuccess(response: data));
        } else if (data.status == 404) {
          emit(ListSemesterStudentFailure(msg: data.message));
        }
      } catch (e) {
        emit(
          ListSemesterStudentFailure(
            msg: e.toString(),
          ),
        );
      }
    });
  }
}

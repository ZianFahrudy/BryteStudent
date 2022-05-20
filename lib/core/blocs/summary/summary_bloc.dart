import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/student/request/class_summary_student_body.dart';
import 'package:bryte/core/data/model/student/response/class_summary_student_model.dart';
import 'package:bryte/core/repo/student/student_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'summary_event.dart';
part 'summary_state.dart';

@injectable
class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  StudentRepository apiRepository;

  SummaryBloc(this.apiRepository) : super(ClassInitial()) {
    on<GetClassSummaryStudent>((event, emit) async {
      try {
        emit(ClassSummaryStudentLoading());
        final data = await apiRepository.getClassSummaryStudent(event.body);
        if (data.status == 200) {
          emit(ClassSummaryStudentSuccess(response: data));
        } else if (data.status == 404) {
          emit(ClassSummaryStudentFailure(data.message));
        }
      } catch (e) {
        emit(ClassSummaryStudentFailure(e.toString()));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/course/request/master_section_body.dart';
import 'package:bryte/core/data/model/course/response/master_course_section_model.dart';
import 'package:bryte/core/repo/course/course_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'master_section_event.dart';
part 'master_section_state.dart';

@injectable
class MasterSectionBloc extends Bloc<MasterSectionEvent, MasterSectionState> {
  CourseRepository apiRepository;
  MasterSectionBloc(this.apiRepository) : super(MasterSectionInitial()) {
    on<GetMasterCourseSection>((event, emit) async {
      try {
        emit(MasterSectionLoading());
        final data = await apiRepository.getMasterCourseSection(event.body);
        if (data.status == 200) {
          emit(MasterSectionSuccess(response: data));
        } else if (data.status == 404) {
          emit(MasterSectionFailure(msg: data.message));
        }
      } catch (e) {
        emit(MasterSectionFailure(msg: e.toString()));
      }
    });
  }
}

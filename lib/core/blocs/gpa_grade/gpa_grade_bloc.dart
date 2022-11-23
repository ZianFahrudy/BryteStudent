import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/profile/request/gpa_grade_body.dart';
import 'package:bryte/core/data/model/profile/response/gpa_grade_model.dart';
import 'package:bryte/core/repo/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'gpa_grade_event.dart';
part 'gpa_grade_state.dart';

@injectable
class GpaGradeBloc extends Bloc<GpaGradeEvent, GpaGradeState> {
  ProfileRepository apiRepository;
  GpaGradeBloc(this.apiRepository) : super(GpaGradeInitial()) {
    on<GetGpaGradeEvent>((event, emit) async {
      try {
        emit(GpaGradeLoading());
        final data = await apiRepository.getGpaGrade(event.body);
        if (data.status == 200) {
          emit(GpaGradeSuccess(response: data));
        } else if (data.status == 404) {
          emit(GpaGradeFailure(msg: data.message));
        }
      } catch (e) {
        emit(
          GpaGradeFailure(
            msg: e.toString(),
          ),
        );
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/profile/request/period_student_body.dart';
import 'package:bryte/core/data/model/profile/response/period_per_student_model.dart';
import 'package:bryte/core/repo/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'academic_period_event.dart';
part 'academic_period_state.dart';

@injectable
class AcademicPeriodBloc
    extends Bloc<AcademicPeriodEvent, AcademicPeriodState> {
  ProfileRepository apiRepository;

  AcademicPeriodBloc(this.apiRepository) : super(AcademicPeriodInitial()) {
    on<GetAcademicPeriodStudentEvent>((event, emit) async {
      try {
        emit(AcademicPeriodLoading());
        final data = await apiRepository.getAcademicPeriodStudent(event.body);
        if (data.status == 200) {
          emit(AcademicPeriodSuccess(response: data));
        } else if (data.status == 404) {
          emit(AcademicPeriodFailure(msg: data.message));
        }
      } catch (e) {
        emit(
          AcademicPeriodFailure(
            msg: e.toString(),
          ),
        );
      }
    });
  }
}

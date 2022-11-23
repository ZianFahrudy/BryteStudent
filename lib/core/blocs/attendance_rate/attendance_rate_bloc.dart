import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/profile/request/attendance_rate_student.dart';
import 'package:bryte/core/data/model/profile/response/attendance_rate_persentase_model.dart';
import 'package:bryte/core/repo/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'attendance_rate_event.dart';
part 'attendance_rate_state.dart';

@injectable
class AttendanceRateBloc
    extends Bloc<AttendanceRateEvent, AttendanceRateState> {
  ProfileRepository apiRepository;
  AttendanceRateBloc(this.apiRepository) : super(AttendanceRateInitial()) {
    on<GetAttendanceRateStudentEvent>(
      (event, emit) async {
        try {
          emit(AttendanceRateLoading());
          final data =
              await apiRepository.getAttendanceRatePersentase(event.body);
          if (data.status == 200) {
            emit(AttendanceRateSuccess(response: data));
          } else if (data.status == 404) {
            emit(AttendanceRateFailure(msg: data.message));
          }
        } catch (e) {
          emit(
            AttendanceRateFailure(
              msg: e.toString(),
            ),
          );
        }
      },
    );
  }
}

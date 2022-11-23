import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../data/model/profile/request/attendance_rate_student.dart';
import '../../../data/model/profile/response/attendance_rate_student_model.dart';
import '../../../repo/profile/profile_repository.dart';

part 'attendance_rate_det_event.dart';
part 'attendance_rate_det_state.dart';

@injectable
class AttendanceRateDetBloc
    extends Bloc<AttendanceRateDetEvent, AttendanceRateDetState> {
  ProfileRepository apiRepository;

  AttendanceRateDetBloc(this.apiRepository)
      : super(AttendanceRateDetInitial()) {
    on<GetAttendaceRateDetEvent>((event, emit) async {
      try {
        emit(AttendanceRateDetLoading());
        final data =
            await apiRepository.getAttendanceRatePerStudent(event.body);
        if (data.status == 200) {
          emit(AttendanceRateDetSuccess(response: data));
        } else if (data.status == 404) {
          emit(AttendanceRateDetFailure(msg: data.message));
        }
      } catch (e) {
        emit(
          AttendanceRateDetFailure(
            msg: e.toString(),
          ),
        );
      }
    });
  }
}

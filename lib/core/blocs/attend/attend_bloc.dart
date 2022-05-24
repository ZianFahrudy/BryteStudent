import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/student/request/submit_attendance_body.dart';
import 'package:bryte/core/repo/student/student_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'attend_event.dart';
part 'attend_state.dart';

@injectable
class AttendBloc extends Bloc<AttendEvent, AttendState> {
  StudentRepository apiRepository;

  AttendBloc(this.apiRepository) : super(AttendInitial()) {
    on<SubmitAttendance>((event, emit) async {
      try {
        emit(AttendLoading());
        final data = await apiRepository.submitAttendance(event.body);

        if (data == 'Sukses') {
          emit(AttendSuccess(response: data));
        } else if (data == 'Gagal') {
          emit(AttendFailure(msg: data));
        }
      } catch (e) {
        emit(AttendFailure(msg: e.toString()));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../data/model/course/request/attendance_body.dart';
import '../../../data/model/course/response/attendance_model.dart';
import '../../../repo/student/student_repository.dart';

part 'attend_list_event.dart';
part 'attend_list_state.dart';

@injectable
class AttendListBloc extends Bloc<AttendListEvent, AttendListState> {
  StudentRepository apiRepository;

  AttendListBloc(this.apiRepository) : super(AttendListInitial()) {
    on<GetAttendListEvent>((event, emit) async {
      try {
        emit(AttendListLoading());
        final data = await apiRepository.getAttendance(event.body);

        if (data.status == 200) {
          emit(AttendListSuccess(response: data));
        } else if (data.status != 200) {
          emit(AttendListFailure(msg: data.message));
        }
      } catch (e) {
        emit(AttendListFailure(msg: e.toString()));
      }
    });
  }
}

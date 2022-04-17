import 'package:bloc/bloc.dart';
import 'package:bryte/core/model/student/request/upcoming_assign_body.dart';
import 'package:bryte/core/model/student/response/upcoming_assign_model.dart';
import 'package:bryte/core/repo/student/student_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

@injectable
class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  StudentRepository apiRepository;

  UpcomingBloc(this.apiRepository) : super(UpcomingInitial()) {
    on<GetUpcomingAssignEvent>((event, emit) async {
      try {
        emit(UpcomingLoading());
        final data = await apiRepository.getUpcomingAssign(event.body);
        if (data.status == 200) {
          emit(UpcomingSuccess(response: data));
        } else if (data.status == 404) {
          emit(UpcomingFailure(msg: data.message));
        }
      } catch (e) {
        emit(UpcomingFailure(msg: e.toString()));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/calendar/request/event_body.dart';
import 'package:bryte/core/data/model/calendar/response/event_model.dart';
import 'package:bryte/core/repo/student/student_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'event_event.dart';
part 'event_state.dart';

@injectable
class EventBloc extends Bloc<EventEvent, EventState> {
  StudentRepository apiRepository;

  EventBloc(this.apiRepository) : super(EventInitial()) {
    on<GetCalendarEvent>((event, emit) async {
      try {
        emit(EventLoading());
        final data = await apiRepository.getCalendarEvent(event.body);
        if (data.status == 200) {
          emit(EventSuccess(data));
        } else if (data.status == 404) {
          emit(EventFailure(data.message));
        }
      } catch (e) {
        emit(EventFailure(e.toString()));
      }
    });

    on<GetCalendarEventPerWeek>((event, emit) async {
      try {
        emit(EventLoading());
        final data = await apiRepository.getCalendarEvent(event.body);
        if (data.status == 200) {
          emit(EventPerWeekSuccess(data));
        } else if (data.status == 404) {
          emit(EventFailure(data.message));
        }
      } catch (e) {
        emit(EventFailure(e.toString()));
      }
    });
  }
}

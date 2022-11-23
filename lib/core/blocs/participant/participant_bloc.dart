import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/course/request/participant_body.dart';
import 'package:bryte/core/data/model/course/response/participant_model.dart';
import 'package:bryte/core/repo/student/student_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'participant_event.dart';
part 'participant_state.dart';

@injectable
class ParticipantBloc extends Bloc<ParticipantEvent, ParticipantState> {
  StudentRepository apiRepository;

  int page = 1;
  bool isFetching = false;
  List<DataListParticipantModel> participants = [];

  ParticipantBloc(this.apiRepository) : super(ParticipantInitial()) {
    on<GetParticipantEvent>(
      (event, emit) async {
        try {
          emit(ParticipantLoading());
          final data = await apiRepository.getParticipant(event.body);
          if (data.status == 200) {
            emit(
              ParticipantSuccess(response: data),
            );
            page++;

            participants.addAll(data.data[0].participant);
          } else if (data.status == 404) {
            emit(
              ParticipantFailure(msg: data.message),
            );
          }
        } catch (e) {
          emit(
            ParticipantFailure(
              msg: e.toString(),
            ),
          );
        }
      },
    );
  }
}

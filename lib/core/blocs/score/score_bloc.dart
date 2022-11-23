import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/course/request/score_body.dart';
import 'package:bryte/core/data/model/course/response/score_model.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../repo/student/student_repository.dart';

part 'score_event.dart';
part 'score_state.dart';

@injectable
class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  StudentRepository apiRepository;

  ScoreBloc(this.apiRepository) : super(ScoreInitial()) {
    on<GetScoreEvent>((event, emit) async {
      try {
        emit(ScoreLoading());
        final data = await apiRepository.getScore(event.body);

        if (data.status == 200) {
          emit(ScoreSuccess(response: data));
        } else {
          emit(ScoreFailure(msg: data.message));
        }
      } catch (e) {
        emit(ScoreFailure(msg: e.toString()));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/course/request/course_body.dart';
import 'package:bryte/core/data/model/course/response/assignment_model.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../repo/course/course_repository.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

@injectable
class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  CourseRepository apiRespository;
  AssignmentBloc(this.apiRespository) : super(AssignmentInitial()) {
    on<GetCourseAssignment>((event, emit) async {
      try {
        emit(AssignmentLoading());
        final data = await apiRespository.getAssignment(event.body);
        if (data.status == 200) {
          emit(AssignmentSuccess(response: data));
        } else if (data.status == 404) {
          emit(AssignmentFailure(msg: data.message));
        }
      } catch (e) {
        emit(
          AssignmentFailure(
            msg: e.toString(),
          ),
        );
      }
    });
  }
}

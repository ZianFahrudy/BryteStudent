import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/course/request/course_body.dart';
import 'package:bryte/core/data/model/course/response/assignment_model.dart';
import 'package:bryte/core/data/model/course/response/course_model.dart';
import 'package:bryte/core/data/model/student/request/general_course_body.dart';
import 'package:bryte/core/data/model/student/response/course_general_model.dart';
import 'package:bryte/core/repo/course/course_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'course_event.dart';
part 'course_state.dart';

@injectable
class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseRepository apiRespository;

  CourseBloc(this.apiRespository) : super(CourseInitial()) {
    on<GetGeneralCourseEvent>(
      (event, emit) async {
        try {
          emit(CourseLoading());
          final data = await apiRespository.getGeneralCourse(event.body);
          if (data.isNotEmpty) {
            emit(CourseSuccess(response: data));
          } else if (data.isEmpty) {
            emit(
              CourseFailed(msg: 'Failed'),
            );
          }
        } catch (e) {
          emit(
            CourseFailed(
              msg: e.toString(),
            ),
          );
        }
      },
    );

    on<GetCourseEvent>(
      (event, emit) async {
        try {
          emit(CourseStudentLoading());
          final data = await apiRespository.getCourse(event.body);
          if (data.status == 200) {
            emit(CourseStudentSuccess(response: data));
          } else if (data.status == 404) {
            emit(CourseFailed(msg: data.message));
          }
        } catch (e) {
          emit(
            CourseFailed(
              msg: e.toString(),
            ),
          );
        }
      },
    );

    on<GetAssignmentCourse>(
      (event, emit) async {
        try {
          emit(CourseAssignmentLoading());
          final data = await apiRespository.getAssignment(event.body);
          if (data.status == 200) {
            emit(CourseAssignmentSuccess(response: data));
          } else if (data.status == 404) {
            emit(CourseAssignmentFailure(msg: data.message));
          }
        } catch (e) {
          emit(
            CourseAssignmentFailure(
              msg: e.toString(),
            ),
          );
        }
      },
    );
  }
}

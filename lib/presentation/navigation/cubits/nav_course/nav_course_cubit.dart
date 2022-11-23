import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'nav_course_state.dart';

@injectable
class NavCourseCubit extends Cubit<NavCourseState> {
  NavCourseCubit() : super(NavCourseInitial());

  bool isCourse = true;

  void toCourseTab() {
    isCourse = true;

    if (isCourse) {
      emit(NavCourseSuccess(isCourse: true));
    } else {
      emit(NavCourseFailure(msg: 'Gagal ke tab course'));
    }
  }

  void toAssignmentTab() {
    isCourse = false;

    if (!isCourse) {
      emit(NavCourseSuccess(isCourse: false));
    } else {
      emit(NavCourseFailure(msg: 'Gagal ke tab assignment'));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/student/request/today_classes_body.dart';
import 'package:bryte/core/data/model/student/response/today_classes_model.dart';
import 'package:bryte/core/repo/student/student_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'class_event.dart';
part 'class_state.dart';

@injectable
class ClassBloc extends Bloc<ClassEvent, ClassState> {
  StudentRepository apiRepository;

  ClassBloc(this.apiRepository) : super(ClassInitial()) {
    on<GetClassesDetStudent>((event, emit) async {
      try {
        emit(ClassLoading());
        final data = await apiRepository.getTodayClasses(event.body);
        if (data.status == 200) {
          emit(ClassSuccess(response: data));
        } else if (data.status == 404) {
          emit(ClassFailure(msg: data.message));
        }
      } catch (e) {
        emit(ClassFailure(msg: e.toString()));
      }
    });
  }
}

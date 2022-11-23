import 'package:bloc/bloc.dart';
import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/core/data/model/moodle/request/assign_save_body.dart';
import 'package:bryte/core/data/model/moodle/request/assign_save_json_body.dart';
import 'package:bryte/core/data/model/moodle/request/assign_submit_file.dart';
import 'package:bryte/core/data/model/moodle/request/upload_file_body.dart';
import 'package:bryte/core/data/model/moodle/response/assign_save_model.dart';
import 'package:bryte/core/data/model/moodle/response/upload_file_model.dart';
import 'package:bryte/core/repo/moodle/moodle_repository.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'moodle_event.dart';
part 'moodle_state.dart';

@injectable
class MoodleBloc extends Bloc<MoodleEvent, MoodleState> {
  final MoodleRepository _apiRepository;
  final box = GetStorage();
  MoodleBloc(this._apiRepository) : super(MoodleInitial()) {
    on<UploadFileEvent>((event, emit) async {
      try {
        emit(MoodleLoading());
        final data = await _apiRepository.uploadFile(event.body);
        if (data.userid == box.read(KeyConstant.userId)) {
          emit(UploadFileSuccess(response: data));
        } else {
          emit(
            MoodleFailure(
              msg: 'Upload File Failed',
            ),
          );
        }
      } catch (e) {
        emit(
          MoodleFailure(
            msg: e.toString(),
          ),
        );
      }
    });

    on<AssignSaveEvent>((event, emit) async {
      try {
        emit(MoodleLoading());
        final data =
            await _apiRepository.assignSaveFile(event.body, event.jsonBody);
        if (data.isEmpty) {
          emit(AssignSaveFileSuccess(response: data));
        } else {
          emit(
            AssignSaveFailure(
              msg: data[0].message,
            ),
          );
        }
      } catch (e) {
        emit(
          AssignSaveFailure(
            msg: e.toString(),
          ),
        );
      }
    });

    on<AssignSubmitEvent>((event, emit) async {
      try {
        emit(MoodleLoading());
        final data =
            await _apiRepository.assignSubmitFile(event.body, event.jsonBody);
        if (data.isEmpty) {
          emit(AssignSubmitFileSuccess(response: data));
        } else {
          emit(
            AssignSubmitFailure(
              msg: data[0].message,
            ),
          );
        }
      } catch (e) {
        emit(
          AssignSubmitFailure(
            msg: e.toString(),
          ),
        );
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:bryte/core/data/model/profile/request/profile_body.dart';
import 'package:bryte/core/data/model/profile/response/profile_model.dart';
import 'package:bryte/core/repo/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository apiRepository;
  ProfileBloc(this.apiRepository) : super(ProfileInitial()) {
    on<GetUserProfileEvent>(
      (event, emit) async {
        try {
          emit(ProfileLoading());
          final data = await apiRepository.getUserProfile(event.body);
          if (data.users.isNotEmpty) {
            emit(ProfileSuccess(response: data));
          } else if (data.users.isEmpty) {
            emit(ProfileFailure(msg: 'Get Profile Failure'));
          }
        } catch (e) {
          emit(
            ProfileFailure(
              msg: e.toString(),
            ),
          );
        }
      },
    );
  }
}

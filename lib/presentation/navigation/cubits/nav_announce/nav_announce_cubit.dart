import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_announce_state.dart';

class NavAnnounceCubit extends Cubit<NavAnnounceState> {
  NavAnnounceCubit() : super(NavAnnounceInitial());

  bool isAnnounce = true;

  void toAnnounceTab() {
    isAnnounce = true;

    if (isAnnounce) {
      emit(
        NavAnnounceSuccess(isAnnounce: true),
      );
    } else {
      emit(
        NavAnnounceFailure(msg: 'Gagal ke tab announce'),
      );
    }
  }

  void toNotifTab() {
    isAnnounce = false;

    if (isAnnounce) {
      emit(
        NavAnnounceSuccess(isAnnounce: false),
      );
    } else {
      emit(
        NavAnnounceFailure(msg: 'Gagal ke tab notif'),
      );
    }
  }
}

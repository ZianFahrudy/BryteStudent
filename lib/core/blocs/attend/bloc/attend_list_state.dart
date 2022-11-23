part of 'attend_list_bloc.dart';

@immutable
abstract class AttendListState {}

class AttendListInitial extends AttendListState {}

class AttendListLoading extends AttendListState {}

class AttendListSuccess extends AttendListState {
  final AttendanceModel response;
  AttendListSuccess({
    required this.response,
  });
}

class AttendListFailure extends AttendListState {
  final String msg;
  AttendListFailure({
    required this.msg,
  });
}

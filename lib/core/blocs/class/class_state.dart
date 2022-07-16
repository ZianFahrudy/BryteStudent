part of 'class_bloc.dart';

@immutable
abstract class ClassState {}

class ClassInitial extends ClassState {}

class ClassLoading extends ClassState {}

class ClassFailure extends ClassState {
  final String msg;
  ClassFailure({
    required this.msg,
  });
}

class ClassSuccess extends ClassState {
  final TodayClassesModel response;
  ClassSuccess({
    required this.response,
  });
}

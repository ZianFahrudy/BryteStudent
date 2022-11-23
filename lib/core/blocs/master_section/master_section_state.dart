part of 'master_section_bloc.dart';

@immutable
abstract class MasterSectionState {}

class MasterSectionInitial extends MasterSectionState {}

class MasterSectionLoading extends MasterSectionState {}

class MasterSectionFailure extends MasterSectionState {
  final String msg;
  MasterSectionFailure({
    required this.msg,
  });
}

class MasterSectionSuccess extends MasterSectionState {
  final MasterCourseSectionModel response;
  MasterSectionSuccess({
    required this.response,
  });
}

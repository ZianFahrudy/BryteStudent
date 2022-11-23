part of 'master_section_bloc.dart';

@immutable
abstract class MasterSectionEvent {}

class GetMasterCourseSection extends MasterSectionEvent {
  final MasterSectionBody body;
  GetMasterCourseSection({
    required this.body,
  });
}

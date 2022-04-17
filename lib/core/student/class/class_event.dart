part of 'class_bloc.dart';

@immutable
abstract class ClassEvent {}

class GetClassesDetStudent extends ClassEvent {
  final TodayClassesBody body;
  GetClassesDetStudent({
    required this.body,
  });
}

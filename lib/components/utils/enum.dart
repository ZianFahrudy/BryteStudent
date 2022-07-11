import 'package:json_annotation/json_annotation.dart';

enum CourseType {
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly
}

enum CourseStatus {
  @JsonValue('past')
  past,
  @JsonValue('ongoing')
  ongoing,
  @JsonValue('today')
  today,
}

enum AssignStatus {
  @JsonValue('SUBMITTED')
  submitted,
  @JsonValue('NOT ATTEMPTED')
  notAttempted,
  @JsonValue('LATED')
  lated,
}

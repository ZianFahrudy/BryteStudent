import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class CourseModel {
  final int status;
  final String message;
  final List<DataCourseModel> data;
  CourseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class DataCourseModel {
  @JsonKey(name: 'idCourse')
  final String idCourse;
  @JsonKey(name: 'idUser')
  final String idUser;
  final String course;
  final String teacherName;
  @JsonKey(name: 'bg_color_1')
  final String bgColor_1;
  @JsonKey(name: 'bg_color_2')
  final String bgColor_2;
  @JsonKey(name: 'text_color_1')
  final String textColor_1;
  @JsonKey(name: 'text_color_2')
  final String textColor_2;
  final String dropShadow;
  DataCourseModel({
    required this.idCourse,
    required this.idUser,
    required this.course,
    required this.teacherName,
    required this.bgColor_1,
    required this.bgColor_2,
    required this.textColor_1,
    required this.textColor_2,
    required this.dropShadow,
  });

  factory DataCourseModel.fromJson(Map<String, dynamic> json) =>
      _$DataCourseModelFromJson(json);
}

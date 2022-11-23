import 'package:json_annotation/json_annotation.dart';

part 'period_per_student_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PeriodPerStudentModel {
  final int status;
  final String message;
  final List<DataPeriodPerStudentModel> data;
  PeriodPerStudentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PeriodPerStudentModel.fromJson(Map<String, dynamic> json) =>
      _$PeriodPerStudentModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class DataPeriodPerStudentModel {
  @JsonKey(name: 'idAperiod')
  final String idAperiod;
  final String aperiod;
  @JsonKey(name: 'periodDescp')
  final String periodDescp;

  DataPeriodPerStudentModel({
    required this.idAperiod,
    required this.aperiod,
    required this.periodDescp,
  });

  factory DataPeriodPerStudentModel.fromJson(Map<String, dynamic> json) =>
      _$DataPeriodPerStudentModelFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_per_student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodPerStudentModel _$PeriodPerStudentModelFromJson(
        Map<String, dynamic> json) =>
    PeriodPerStudentModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              DataPeriodPerStudentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataPeriodPerStudentModel _$DataPeriodPerStudentModelFromJson(
        Map<String, dynamic> json) =>
    DataPeriodPerStudentModel(
      idAperiod: json['idAperiod'] as String,
      aperiod: json['aperiod'] as String,
      periodDescp: json['periodDescp'] as String,
    );

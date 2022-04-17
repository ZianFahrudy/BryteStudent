// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_summary_student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassSummaryStudentModel _$ClassSummaryStudentModelFromJson(
        Map<String, dynamic> json) =>
    ClassSummaryStudentModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: DataClassSummaryStudentModel.fromJson(
          json['data'] as Map<String, dynamic>),
    );

DataClassSummaryStudentModel _$DataClassSummaryStudentModelFromJson(
        Map<String, dynamic> json) =>
    DataClassSummaryStudentModel(
      todayClasses: json['today_classes'] as int,
      assignAll: json['assign_all'] as int,
      assignTomorrow: json['assign_tomorrow'] as int,
      assignThisWeek: json['assign_this_week'] as int,
    );

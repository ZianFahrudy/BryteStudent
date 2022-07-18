// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailAssignmentModel _$DetailAssignmentModelFromJson(
        Map<String, dynamic> json) =>
    DetailAssignmentModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              DataDetailAssignmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataDetailAssignmentModel _$DataDetailAssignmentModelFromJson(
        Map<String, dynamic> json) =>
    DataDetailAssignmentModel(
      idCourse: json['idCourse'] as String,
      courseName: json['course_name'] as String,
      idTeacher: json['idTeacher'] as String,
      teacherName: json['teacher_name'] as String,
      teacherImg: json['teacher_img'] as String,
      assignments: (json['assignments'] as List<dynamic>)
          .map((e) =>
              DataAssigmentmentsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataAssigmentmentsModel _$DataAssigmentmentsModelFromJson(
        Map<String, dynamic> json) =>
    DataAssigmentmentsModel(
      idAssign: json['idAssign'] as String,
      assignName: json['assign_name'] as String,
      assignDescp: json['assign_descp'] as String,
      assignAllowfrom: json['assign_allowfrom'] as String,
      assignDeadline: json['assign_deadline'] as String,
      assignTimeRemaining: json['assign_time_remaining'] as String,
      assignStatus: json['assign_status'] as String,
      assignGrade: json['assign_grade'] as String,
      assignMaxSize: json['assign_max_size'] as String,
      assignFileTypes: json['assign_file_types'] as String,
      assignFile: (json['assign_file'] as List<dynamic>)
          .map((e) => AssignFileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AssignFileModel _$AssignFileModelFromJson(Map<String, dynamic> json) =>
    AssignFileModel(
      fileName: json['file_name'] as String,
      fileUrl: json['file_url'] as String,
    );

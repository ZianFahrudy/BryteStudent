// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_per_course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentPerCourseModel _$AssignmentPerCourseModelFromJson(
        Map<String, dynamic> json) =>
    AssignmentPerCourseModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              DataAssignmentPerCourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataAssignmentPerCourseModel _$DataAssignmentPerCourseModelFromJson(
        Map<String, dynamic> json) =>
    DataAssignmentPerCourseModel(
      idCourse: json['idCourse'] as String,
      courseName: json['course_name'] as String,
      idTeacher: json['idTeacher'] as String,
      teacherName: json['teacher_name'] as String,
      teacherImg: json['teacher_img'] as String,
      assignments: (json['assignments'] as List<dynamic>)
          .map((e) => DataAssignmentsListCourseModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

DataAssignmentsListCourseModel _$DataAssignmentsListCourseModelFromJson(
        Map<String, dynamic> json) =>
    DataAssignmentsListCourseModel(
      assignUpcomming: (json['assign_upcomming'] as List<dynamic>)
          .map((e) => DataAssignmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      assignPastDue: (json['assign_past_due'] as List<dynamic>)
          .map((e) => DataAssignmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataAssignmentModel _$DataAssignmentModelFromJson(Map<String, dynamic> json) =>
    DataAssignmentModel(
      idCourse: json['idCourse'] as String,
      idAssign: json['idAssign'] as String,
      assignName: json['assign_name'] as String,
      assignDescp: json['assign_descp'] as String,
      assignAllowfrom: json['assign_allowfrom'] as String,
      assignDeadline: json['assign_deadline'] as String,
      assignSubmit: json['assign_submit'] as String?,
      assignStatus: json['assign_status'] as String,
    );

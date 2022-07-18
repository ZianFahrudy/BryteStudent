// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_classes_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TodayClassesBodyToJson(TodayClassesBody instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userid': instance.userid,
      'type': _$CourseTypeEnumMap[instance.type]!,
      'date': instance.date,
    };

const _$CourseTypeEnumMap = {
  CourseType.daily: 'daily',
  CourseType.weekly: 'weekly',
  CourseType.monthly: 'monthly',
};

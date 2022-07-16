
import 'package:json_annotation/json_annotation.dart';

import '../../../../../components/utils/enum.dart';
part 'today_classes_body.g.dart';

@JsonSerializable(createFactory: false)
class TodayClassesBody {
  final String token;
  final String userid;
  final CourseType type;
  final String date;
  TodayClassesBody({
    required this.token,
    required this.userid,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toJson() => _$TodayClassesBodyToJson(this);
}

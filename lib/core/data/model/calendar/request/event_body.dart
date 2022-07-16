import 'package:json_annotation/json_annotation.dart';

part 'event_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class EventBody {
  EventBody({
    required this.token,
    required this.userid,
    required this.startDate,
    required this.endDate,
  });
  final String token;
  final String userid;
  final String startDate;
  final String endDate;

  Map<String, dynamic> toJson() => _$EventBodyToJson(this);
}

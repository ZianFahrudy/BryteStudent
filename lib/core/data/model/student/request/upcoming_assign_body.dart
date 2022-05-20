import 'package:json_annotation/json_annotation.dart';

part 'upcoming_assign_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class UpcomingAssignBody {
  final String token;
  final String userid;
  UpcomingAssignBody({
    required this.token,
    required this.userid,
  });

  Map<String, dynamic> toJson() => _$UpcomingAssignBodyToJson(this);
}

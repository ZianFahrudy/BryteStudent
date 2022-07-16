import 'package:json_annotation/json_annotation.dart';

part 'profile_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class ProfileBody {
  final String wstoken;
  final String wsfunction;
  final String moodlewsrestformat;
  @JsonKey(name: 'criteria[0][key]')
  final String criteriaid;
  @JsonKey(name: 'criteria[0][value]')
  final int criteriauserid;

  ProfileBody({
    required this.wstoken,
    required this.wsfunction,
    required this.moodlewsrestformat,
    required this.criteriaid,
    required this.criteriauserid,
  });

  Map<String, dynamic> toJson() => _$ProfileBodyToJson(this);
}

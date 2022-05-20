import 'package:json_annotation/json_annotation.dart';

part 'announcement_body.g.dart';

@JsonSerializable(createFactory: false)
class AnnouncementBody {
  final String token;
  AnnouncementBody({
    required this.token,
  });
  Map<String, dynamic> toJson() => _$AnnouncementBodyToJson(this);
}

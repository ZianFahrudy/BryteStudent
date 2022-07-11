import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProfileModel {
  final List<UserModel> users;
  ProfileModel({
    required this.users,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class UserModel {
  final int? id;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? fullname;
  final String? email;
  final String? department;
  final int? firstaccess;
  final int? lastaccess;
  final String? auth;
  final bool? suspended;
  final bool? confirmed;
  final String? lang;
  final String? theme;
  final String? timezone;
  final int? mailformat;
  final String? description;
  final int? descriptionformat;
  final String? profileimageurlsmall;
  final String? profileimageurl;
  UserModel({
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.fullname,
    this.email,
    this.department,
    this.firstaccess,
    this.lastaccess,
    this.auth,
    this.suspended,
    this.confirmed,
    this.lang,
    this.theme,
    this.timezone,
    this.mailformat,
    this.description,
    this.descriptionformat,
    this.profileimageurlsmall,
    this.profileimageurl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

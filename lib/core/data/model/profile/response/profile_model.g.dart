// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      username: json['username'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      department: json['department'] as String?,
      firstaccess: json['firstaccess'] as int?,
      lastaccess: json['lastaccess'] as int?,
      auth: json['auth'] as String?,
      suspended: json['suspended'] as bool?,
      confirmed: json['confirmed'] as bool?,
      lang: json['lang'] as String?,
      theme: json['theme'] as String?,
      timezone: json['timezone'] as String?,
      mailformat: json['mailformat'] as int?,
      description: json['description'] as String?,
      descriptionformat: json['descriptionformat'] as int?,
      profileimageurlsmall: json['profileimageurlsmall'] as String?,
      profileimageurl: json['profileimageurl'] as String?,
    );

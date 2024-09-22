// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_text_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoTextRequest _$UserInfoTextRequestFromJson(Map<String, dynamic> json) =>
    UserInfoTextRequest(
      nickname: json['nickname'] as String,
      username: json['username'] as String,
      department: json['department'] as String,
    );

Map<String, dynamic> _$UserInfoTextRequestToJson(
        UserInfoTextRequest instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'username': instance.username,
      'department': instance.department,
    };

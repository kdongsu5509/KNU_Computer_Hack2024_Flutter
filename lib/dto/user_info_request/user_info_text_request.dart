import 'package:json_annotation/json_annotation.dart';

part 'user_info_text_request.g.dart';

@JsonSerializable()
class UserInfoTextRequest {
  final String nickname;
  final String username;
  final String department;

  UserInfoTextRequest({
    required this.nickname,
    required this.username,
    required this.department,
  });

  factory UserInfoTextRequest.fromJson(Map<String, dynamic> json) =>
      _$UserInfoTextRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoTextRequestToJson(this);
}
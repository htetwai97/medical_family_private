// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLoginResponse _$PostLoginResponseFromJson(Map<String, dynamic> json) =>
    PostLoginResponse(
      message: json['message'] as String?,
      status: json['status'] as int?,
      accessToken: json['access_token'] as String?,
      user: json['user'] == null
          ? null
          : UserVO.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostLoginResponseToJson(PostLoginResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'access_token': instance.accessToken,
      'user': instance.user,
    };

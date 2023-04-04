import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/user_vo.dart';
part 'post_login_response.g.dart';

@JsonSerializable()
class PostLoginResponse {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "status")
  int? status;

  @JsonKey(name: "access_token")
  String? accessToken;

  @JsonKey(name: "user")
  UserVO? user;

  PostLoginResponse({
    this.message,
    this.status,
    this.accessToken,
    this.user,
  });

  factory PostLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$PostLoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostLoginResponseToJson(this);

  @override
  String toString() {
    return 'PostLoginResponse{message: $message, status: $status, accessToken: $accessToken, user: $user}';
  }
}

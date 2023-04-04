import 'package:json_annotation/json_annotation.dart';
part 'post_email_success_response.g.dart';
@JsonSerializable()
class PostEmailSuccessResponse {
  @JsonKey(name: "message")
  String? message;
  PostEmailSuccessResponse({this.message});

  factory PostEmailSuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$PostEmailSuccessResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostEmailSuccessResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'post_register_response.g.dart';
@JsonSerializable()
class PostRegisterResponse{
  @JsonKey(name: "data")
  int? data;
  PostRegisterResponse(this.data);

  factory PostRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$PostRegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostRegisterResponseToJson(this);

  @override
  String toString() {
    return 'PostRegisterResponse{data: $data}';
  }
}
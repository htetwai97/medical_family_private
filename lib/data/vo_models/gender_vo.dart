import 'package:json_annotation/json_annotation.dart';
part 'gender_vo.g.dart';

@JsonSerializable()
class GenderVO {
  @JsonKey(name: "gender")
  Map<String, dynamic>? genders;

  GenderVO({this.genders});

  factory GenderVO.fromJson(Map<String, dynamic> json) =>
      _$GenderVOFromJson(json);
  Map<String, dynamic> toJson() => _$GenderVOToJson(this);
}

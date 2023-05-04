import 'package:json_annotation/json_annotation.dart';
part 'color_for_family_arrow_vo.g.dart';

@JsonSerializable()
class ColorForFamilyArrowVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "colour_name")
  String? colorName;

  @JsonKey(name: "colour_description")
  String? colorDescription;

  @JsonKey(name: "color_hex_code")
  String? colorHexCode;

  @JsonKey(name: "fabric")
  dynamic fabric;

  ColorForFamilyArrowVO({
    this.id,
    this.colorName,
    this.colorDescription,
    this.colorHexCode,
    this.fabric,
  });

  factory ColorForFamilyArrowVO.fromJson(Map<String, dynamic> json) =>
      _$ColorForFamilyArrowVOFromJson(json);
  Map<String, dynamic> toJson() => _$ColorForFamilyArrowVOToJson(this);
}

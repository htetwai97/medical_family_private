import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/color_for_family_arrow_vo.dart';
part 'get_colors_for_family_arrow_response.g.dart';

@JsonSerializable()
class GetColorsForFamilyArrowResponse {
  @JsonKey(name: "color")
  List<ColorForFamilyArrowVO?>? colorObjects;
  GetColorsForFamilyArrowResponse({this.colorObjects});

  factory GetColorsForFamilyArrowResponse.fromJson(Map<String, dynamic> json) =>
      _$GetColorsForFamilyArrowResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetColorsForFamilyArrowResponseToJson(this);
}

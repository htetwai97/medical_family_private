import 'package:json_annotation/json_annotation.dart';
part 'gender_instock_order_vo.g.dart';

@JsonSerializable()
class GenderInStockOrderVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "gender_name")
  String? genderName;

  @JsonKey(name: "gender_description")
  String? genderDescription;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  GenderInStockOrderVO({
    this.id,
    this.genderName,
    this.genderDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory GenderInStockOrderVO.fromJson(Map<String, dynamic> json) =>
      _$GenderInStockOrderVOFromJson(json);
  Map<String, dynamic> toJson() => _$GenderInStockOrderVOToJson(this);
}

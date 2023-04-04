import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/gender_instock_order_vo.dart';
part 'size_instock_order_vo.g.dart';

@JsonSerializable()
class SizeInStockOrderVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "size_name")
  String? sizeName;

  @JsonKey(name: "size_description")
  String? sizeDescription;

  @JsonKey(name: "gender_id")
  int? genderId;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "gender")
  GenderInStockOrderVO? gender;

  SizeInStockOrderVO({
    this.id,
    this.sizeName,
    this.sizeDescription,
    this.genderId,
    this.createdAt,
    this.updatedAt,
    this.gender,
  });

  factory SizeInStockOrderVO.fromJson(Map<String, dynamic> json) =>
      _$SizeInStockOrderVOFromJson(json);
  Map<String, dynamic> toJson() => _$SizeInStockOrderVOToJson(this);
}

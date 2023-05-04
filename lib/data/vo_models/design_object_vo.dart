import 'package:json_annotation/json_annotation.dart';
part 'design_object_vo.g.dart';
@JsonSerializable()
class DesignObjectVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "design_name")
  String? designName;

  @JsonKey(name: "design_description")
  String? designDescription;

  @JsonKey(name: "normal_size_price")
  int? normalSizePrice;

  @JsonKey(name: "plus_size_price")
  int? plusSizePrice;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  DesignObjectVO({
    this.id,
    this.designName,
    this.designDescription,
    this.normalSizePrice,
    this.plusSizePrice,
    this.createdAt,
    this.updatedAt,
  });

  factory DesignObjectVO.fromJson(Map<String, dynamic> json) =>
      _$DesignObjectVOFromJson(json);
  Map<String, dynamic> toJson() => _$DesignObjectVOToJson(this);

  @override
  String toString() {
    return 'DesignObjectVO{id: $id, designName: $designName, designDescription: $designDescription, normalSizePrice: $normalSizePrice, plusSizePrice: $plusSizePrice, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

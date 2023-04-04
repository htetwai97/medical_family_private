import 'package:json_annotation/json_annotation.dart';
part 'design_instock_order_vo.g.dart';

@JsonSerializable()
class DesignInStockOrderVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "design_name")
  String? designName;

  @JsonKey(name: "design_description")
  String? designDescription;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  DesignInStockOrderVO({
    this.id,
    this.designName,
    this.designDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory DesignInStockOrderVO.fromJson(Map<String, dynamic> json) =>
      _$DesignInStockOrderVOFromJson(json);
  Map<String, dynamic> toJson() => _$DesignInStockOrderVOToJson(this);
}

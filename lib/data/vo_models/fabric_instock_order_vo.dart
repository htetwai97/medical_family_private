import 'package:json_annotation/json_annotation.dart';
part 'fabric_instock_order_vo.g.dart';

@JsonSerializable()
class FabricInStockOrderVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "fabric_name")
  String? fabricName;

  @JsonKey(name: "fabric_description")
  String? fabricDescription;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  FabricInStockOrderVO({
    this.id,
    this.fabricName,
    this.fabricDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory FabricInStockOrderVO.fromJson(Map<String, dynamic> json) =>
      _$FabricInStockOrderVOFromJson(json);
  Map<String, dynamic> toJson() => _$FabricInStockOrderVOToJson(this);
}

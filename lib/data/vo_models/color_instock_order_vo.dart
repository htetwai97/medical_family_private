import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/fabric_instock_order_vo.dart';
part 'color_instock_order_vo.g.dart';

@JsonSerializable()
class ColorInStockOrderVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "colour_name")
  String? colourName;

  @JsonKey(name: "colour_description")
  String? colourDescription;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "fabric_id")
  int? fabricId;

  @JsonKey(name: "fabric")
  FabricInStockOrderVO? fabric;

  ColorInStockOrderVO({
    this.id,
    this.colourName,
    this.colourDescription,
    this.createdAt,
    this.updatedAt,
    this.fabricId,
    this.fabric,
  });

  factory ColorInStockOrderVO.fromJson(Map<String, dynamic> json) =>
      _$ColorInStockOrderVOFromJson(json);
  Map<String, dynamic> toJson() => _$ColorInStockOrderVOToJson(this);
}

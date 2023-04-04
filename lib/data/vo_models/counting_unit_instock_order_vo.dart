import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/color_instock_order_vo.dart';
import 'package:medical_family_app/data/vo_models/design_instock_order_vo.dart';
import 'package:medical_family_app/data/vo_models/size_instock_order_vo.dart';
part 'counting_unit_instock_order_vo.g.dart';

@JsonSerializable()
class CountingUnitInStockOrderVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "unit_code")
  String? unitCode;

  @JsonKey(name: "original_code")
  String? originalCode;

  @JsonKey(name: "unit_name")
  String? unitName;

  @JsonKey(name: "design_id")
  int? designId;

  @JsonKey(name: "current_quantity")
  int? currentQuantity;

  @JsonKey(name: "reorder_quantity")
  int? reorderQuantity;

  @JsonKey(name: "reset_quantity")
  int? resetQuantity;

  @JsonKey(name: "order_price")
  int? orderPrice;

  @JsonKey(name: "purchase_price")
  int? purchasePrice;

  @JsonKey(name: "item_id")
  int? itemId;

  @JsonKey(name: "deleted_at")
  String? deletedAt;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "order_fixed_flash")
  int? orderFixedFlash;

  @JsonKey(name: "order_fixed_percent")
  int? orderFixedPercent;

  @JsonKey(name: "reserved_qty")
  int? reservedQty;

  @JsonKey(name: "fabric_id")
  int? fabricId;

  @JsonKey(name: "colour_id")
  int? colourId;

  @JsonKey(name: "size_id")
  int? sizeId;

  @JsonKey(name: "gender_id")
  int? genderId;

  @JsonKey(name: "design")
  DesignInStockOrderVO? design;

  @JsonKey(name: "colour")
  ColorInStockOrderVO? colour;

  @JsonKey(name: "size")
  SizeInStockOrderVO? size;

  CountingUnitInStockOrderVO({
    this.id,
    this.unitCode,
    this.originalCode,
    this.unitName,
    this.designId,
    this.currentQuantity,
    this.reorderQuantity,
    this.resetQuantity,
    this.orderPrice,
    this.purchasePrice,
    this.itemId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.orderFixedFlash,
    this.orderFixedPercent,
    this.reservedQty,
    this.fabricId,
    this.colourId,
    this.sizeId,
    this.genderId,
    this.design,
    this.colour,
    this.size,
  });

  factory CountingUnitInStockOrderVO.fromJson(Map<String, dynamic> json) =>
      _$CountingUnitInStockOrderVOFromJson(json);
  Map<String, dynamic> toJson() => _$CountingUnitInStockOrderVOToJson(this);
}

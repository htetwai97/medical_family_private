import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/counting_unit_instock_order_vo.dart';
part 'unit_instock_order_vo.g.dart';

@JsonSerializable()
class UnitInStockOrderVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "order_id")
  int? orderId;

  @JsonKey(name: "counting_unit_id")
  int? countingUnitId;

  @JsonKey(name: "quantity")
  int? quantity;

  @JsonKey(name: "price")
  int? price;

  @JsonKey(name: "discount_type")
  String? discountType;

  @JsonKey(name: "discount_value")
  int? discountValue;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  CountingUnitInStockOrderVO? countingUnitInStockOrder;

  UnitInStockOrderVO({
    this.id,
    this.orderId,
    this.countingUnitId,
    this.quantity,
    this.price,
    this.discountType,
    this.discountValue,
    this.createdAt,
    this.updatedAt,
    this.countingUnitInStockOrder,
  });

  factory UnitInStockOrderVO.fromJson(Map<String, dynamic> json) =>
      _$UnitInStockOrderVOFromJson(json);
  Map<String, dynamic> toJson() => _$UnitInStockOrderVOToJson(this);
}

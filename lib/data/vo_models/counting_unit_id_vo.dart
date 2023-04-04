import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/persistence/hive/hive_constants.dart';
part 'counting_unit_id_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_COUNTING_UNIT_BY_ID_VO,
    adapterName: "CountingUnitIdVOAdapter")
class CountingUnitIdVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "unit_code")
  @HiveField(1)
  String? unitCode;

  @JsonKey(name: "unit_name")
  @HiveField(2)
  String? unitName;

  @JsonKey(name: "design_name")
  @HiveField(3)
  String? designName;

  @JsonKey(name: "fabric_name")
  @HiveField(4)
  String? fabricName;

  @JsonKey(name: "colour_name")
  @HiveField(5)
  String? colorName;

  @JsonKey(name: "size_name")
  @HiveField(6)
  String? sizeName;

  @JsonKey(name: "gender_name")
  @HiveField(7)
  String? genderName;

  @JsonKey(name: "current_quantity")
  @HiveField(8)
  int? currentQuantity;

  @JsonKey(name: "order_price")
  @HiveField(9)
  int? orderPrice;

  @JsonKey(name: "purchase_price")
  @HiveField(10)
  int? purchasePrice;

  @JsonKey(name: "item_id")
  @HiveField(11)
  int? itemId;

  CountingUnitIdVO({
    this.id,
    this.unitCode,
    this.unitName,
    this.designName,
    this.fabricName,
    this.colorName,
    this.sizeName,
    this.genderName,
    this.currentQuantity,
    this.orderPrice,
    this.purchasePrice,
    this.itemId,
  });

  factory CountingUnitIdVO.fromJson(Map<String, dynamic> json) =>
      _$CountingUnitIdVOFromJson(json);
  Map<String, dynamic> toJson() => _$CountingUnitIdVOToJson(this);

  @override
  String toString() {
    return 'CountingUnitIdVO{id: $id, unitCode: $unitCode, unitName: $unitName, designName: $designName, fabricName: $fabricName, colorName: $colorName, sizeName: $sizeName, genderName: $genderName, currentQuantity: $currentQuantity, orderPrice: $orderPrice, purchasePrice: $purchasePrice, itemId: $itemId}';
  }
}

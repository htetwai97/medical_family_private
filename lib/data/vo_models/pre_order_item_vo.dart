import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/persistence/hive/hive_constants.dart';
part 'pre_order_item_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_PRE_ORDER_ITEM_VO,
    adapterName: "PreOrderItemVOAdapter")
class PreOrderItemVO {
  @JsonKey(name: "testname")
  @HiveField(0)
  String? itemName;

  @JsonKey(name: "testqty")
  @HiveField(1)
  String? quantity;

  @HiveField(2)
  String? price;

  @JsonKey(name: "testprice")
  @HiveField(3)
  String? total;

  @HiveField(4)
  bool? isBrand;

  @HiveField(5)
  String? userId;

  @JsonKey(name: "orderid")
  @HiveField(6)
  String? orderId;

  PreOrderItemVO({
    this.itemName,
    this.quantity,
    this.price,
    this.total,
    this.isBrand,
    this.userId,
    this.orderId,
  });

  factory PreOrderItemVO.fromJson(Map<String, dynamic> json) =>
      _$PreOrderItemVOFromJson(json);
  Map<String, dynamic> toJson() => _$PreOrderItemVOToJson(this);
}

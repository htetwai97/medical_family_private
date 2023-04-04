import 'dart:io';
import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/persistence/hive/hive_constants.dart';
part 'custom_pre_order_item_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_CUSTOM_PRE_ORDER_ITEM_VO,
    adapterName: "CustomPreOrderItemVOAdapter")
class CustomPreOrderItemVO {
  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(0)
  Uint8List? attach;

  @JsonKey(name: "files")
  @HiveField(9)
  String? filePath;

  @JsonKey(name: "testqty")
  @HiveField(1)
  String? quantity;

  @JsonKey(name: "testprice")
  @HiveField(2)
  String? price;

  @JsonKey(name: "description")
  @HiveField(3)
  String? description;

  @HiveField(4)
  String? totalQuantity;

  @HiveField(5)
  String? totalAmount;

  @HiveField(6)
  String? userId;

  @JsonKey(name: "orderid")
  @HiveField(7)
  String? orderId;

  @HiveField(8)
  String? timeStamp;

  @JsonKey(includeFromJson: false, includeToJson: false)
  File? file;

  CustomPreOrderItemVO({
    this.attach,
    this.quantity,
    this.price,
    this.description,
    this.totalQuantity,
    this.totalAmount,
    this.userId,
    this.orderId,
    this.timeStamp,
    this.filePath,
    this.file,
  });

  factory CustomPreOrderItemVO.fromJson(Map<String, dynamic> json) =>
      _$CustomPreOrderItemVOFromJson(json);
  Map<String, dynamic> toJson() => _$CustomPreOrderItemVOToJson(this);
}

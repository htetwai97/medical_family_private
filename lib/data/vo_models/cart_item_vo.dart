import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/persistence/hive/hive_constants.dart';
part 'cart_item_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CART_ITEM_VO, adapterName: "CartItemVOAdapter")
class CartItemVO {
  @HiveField(0)
  String? cartItemId;

  @HiveField(1)
  String? userId;

  @HiveField(2)
  String? itemName;

  @JsonKey(name: "unitid")
  @HiveField(3)
  int? countingUnitId;

  @HiveField(4)
  String? gender;

  @JsonKey(name: "color")
  @HiveField(5)
  String? color;

  @JsonKey(name: "fabric")
  @HiveField(6)
  String? fabric;

  @JsonKey(name: "size")
  @HiveField(7)
  String? size;

  @HiveField(8)
  int? updatePrice;

  @JsonKey(name: "quantity")
  @HiveField(9)
  int? quantity;

  @JsonKey(name: "unitimg")
  @HiveField(10)
  String? itemImage;

  @JsonKey(name: "unitcode")
  @HiveField(11)
  String? unitCode;

  @JsonKey(name: "price")
  @HiveField(12)
  int? price;

  @HiveField(13)
  int? stockQuantity;

  @JsonKey(name: "unitname")
  @HiveField(14)
  String? unitName;

  CartItemVO({
    this.cartItemId,
    this.userId,
    this.itemName,
    this.countingUnitId,
    this.gender,
    this.color,
    this.fabric,
    this.size,
    this.updatePrice,
    this.quantity,
    this.itemImage,
    this.unitCode,
    this.price,
    this.stockQuantity,
    this.unitName,
  });

  factory CartItemVO.fromJson(Map<String, dynamic> json) =>
      _$CartItemVOFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemVOToJson(this);
}

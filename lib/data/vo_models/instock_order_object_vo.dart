import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/cart_item_vo.dart';
part 'instock_order_object_vo.g.dart';

@JsonSerializable()
class InStockOrderVO {
  @JsonKey(name: "id")
  int? userId;

  @JsonKey(name: "name")
  String? userName;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "address")
  String? address;

  @JsonKey(name: "township")
  String? township;

  @JsonKey(name: "charges")
  int? charges;

  @JsonKey(name: "paymenttype")
  String? paymentType;

  @JsonKey(name: "paymentchannel")
  String? paymentChannel;

  @JsonKey(name: "remark")
  String? remark;

  @JsonKey(name: "products")
  List<CartItemVO?>? products;

  @JsonKey(name: "quantity")
  int? quantity;

  @JsonKey(name: "amount")
  int? total;

  InStockOrderVO({
    this.userId,
    this.userName,
    this.phone,
    this.address,
    this.township,
    this.charges,
    this.paymentType,
    this.paymentChannel,
    this.remark,
    this.products,
    this.quantity,
    this.total,
  });

  factory InStockOrderVO.fromJson(Map<String, dynamic> json) =>
      _$InStockOrderVOFromJson(json);
  Map<String, dynamic> toJson() => _$InStockOrderVOToJson(this);
}

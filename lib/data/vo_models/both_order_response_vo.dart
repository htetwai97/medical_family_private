import 'package:json_annotation/json_annotation.dart';
part 'both_order_response_vo.g.dart';

@JsonSerializable()
class BothOrderResponseVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "order_code")
  String? orderCode;

  @JsonKey(name: "order_date")
  String? orderDate;

  @JsonKey(name: "customer_id")
  int? customerId;

  @JsonKey(name: "customer_name")
  String? customerName;

  @JsonKey(name: "customer_phone")
  String? customerPhone;

  @JsonKey(name: "order_type")
  int? orderType;

  @JsonKey(name: "order_status")
  String? orderStatus;

  @JsonKey(name: "attach_flag")
  int? attachFlag;

  @JsonKey(name: "total_quantity")
  dynamic totalQuantity;

  @JsonKey(name: "total_amount")
  dynamic totalAmount;

  @JsonKey(name: "delivery_fee")
  int? deliveryFee;

  @JsonKey(name: "delivered_date")
  String? deliveryDate;

  @JsonKey(name: "delivered_by")
  String? deliveredBy;

  @JsonKey(name: "delivered_remark")
  String? deliveredRemark;

  @JsonKey(name: "discount_type")
  String? discountType;

  @JsonKey(name: "discount_amount")
  int? discountAmount;

  @JsonKey(name: "payment_type")
  String? paymentType;

  @JsonKey(name: "payment_channel")
  String? paymentChannel;

  @JsonKey(name: "advance")
  int? advance;

  @JsonKey(name: "collect_amount")
  int? collectAmount;

  @JsonKey(name: "deliver_address")
  String? deliverAddress;

  @JsonKey(name: "billing_address")
  String? billingAddress;

  @JsonKey(name: "remark")
  String? remark;

  @JsonKey(name: "status")
  int? status;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  BothOrderResponseVO({
    this.id,
    this.orderCode,
    this.orderDate,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.orderType,
    this.orderStatus,
    this.attachFlag,
    this.totalQuantity,
    this.totalAmount,
    this.deliveryFee,
    this.deliveryDate,
    this.deliveredBy,
    this.deliveredRemark,
    this.discountType,
    this.discountAmount,
    this.paymentType,
    this.paymentChannel,
    this.advance,
    this.collectAmount,
    this.deliverAddress,
    this.billingAddress,
    this.remark,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BothOrderResponseVO.fromJson(Map<String, dynamic> json) =>
      _$BothOrderResponseVOFromJson(json);
  Map<String, dynamic> toJson() => _$BothOrderResponseVOToJson(this);
}

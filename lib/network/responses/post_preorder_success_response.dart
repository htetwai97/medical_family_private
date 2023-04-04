import 'package:json_annotation/json_annotation.dart';
part 'post_preorder_success_response.g.dart';

@JsonSerializable()
class PostPreOrderSuccessResponse {
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

  @JsonKey(name: "total_quantity")
  int? totalQuantity;

  @JsonKey(name: "order_status")
  String? orderStatus;

  @JsonKey(name: "deliver_address")
  String? deliverAddress;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "total_amount")
  int? totalAmount;

  PostPreOrderSuccessResponse({
    this.orderCode,
    this.orderDate,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.orderType,
    this.totalQuantity,
    this.orderStatus,
    this.deliverAddress,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.totalAmount,
  });

  factory PostPreOrderSuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$PostPreOrderSuccessResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostPreOrderSuccessResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'post_payment_response.g.dart';

@JsonSerializable()
class PostPaymentResponse {
  @JsonKey(name: "ecommerce_order_id")
  int? ecommerceOrderId;

  @JsonKey(name: "screenshot")
  String? screenShot;

  @JsonKey(name: "amount")
  String? amount;

  @JsonKey(name: "remark")
  String? remark;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "id")
  int? id;

  PostPaymentResponse({
    this.ecommerceOrderId,
    this.screenShot,
    this.amount,
    this.remark,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory PostPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PostPaymentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostPaymentResponseToJson(this);
}

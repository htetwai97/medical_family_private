import 'package:json_annotation/json_annotation.dart';
part 'attach_vo.g.dart';

@JsonSerializable()
class AttachVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "order_id")
  int? orderId;

  @JsonKey(name: "item_photo")
  String? itemPhoto;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "quantity")
  int? quantity;

  @JsonKey(name: "price")
  int? price;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  AttachVO({
    this.id,
    this.orderId,
    this.itemPhoto,
    this.description,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory AttachVO.fromJson(Map<String, dynamic> json) =>
      _$AttachVOFromJson(json);
  Map<String, dynamic> toJson() => _$AttachVOToJson(this);
}

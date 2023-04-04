import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/pre_order_item_vo.dart';
part 'post_pre_order_object_vo.g.dart';

@JsonSerializable()
class PostPreOrderObjectVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "address")
  String? address;

  @JsonKey(name: "orders")
  List<PreOrderItemVO?>? orders;

  PostPreOrderObjectVO({
    this.id,
    this.name,
    this.address,
    this.orders,
    this.phone,
  });

  factory PostPreOrderObjectVO.fromJson(Map<String, dynamic> json) =>
      _$PostPreOrderObjectVOFromJson(json);
  Map<String, dynamic> toJson() => _$PostPreOrderObjectVOToJson(this);
}

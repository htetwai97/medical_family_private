import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/both_order_response_vo.dart';
part 'order_list_response.g.dart';

@JsonSerializable()
class OrderListResponse {
  @JsonKey(name: "instock")
  List<BothOrderResponseVO?>? inStock = [];

  @JsonKey(name: "preorder")
  List<BothOrderResponseVO?>? preOrder = [];

  OrderListResponse({
    this.inStock,
    this.preOrder,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderListResponseToJson(this);
}

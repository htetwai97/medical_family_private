import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/both_order_response_vo.dart';
part 'order_save_success_response.g.dart';
@JsonSerializable()
class OrderSaveSuccessResponse {
  @JsonKey(name: "data")
  BothOrderResponseVO? data;

  OrderSaveSuccessResponse({
    this.data,
  });

  factory OrderSaveSuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderSaveSuccessResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderSaveSuccessResponseToJson(this);
}

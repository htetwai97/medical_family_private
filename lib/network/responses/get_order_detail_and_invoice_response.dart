import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/attach_vo.dart';
import 'package:medical_family_app/data/vo_models/counting_unit_instock_order_vo.dart';
import 'package:medical_family_app/data/vo_models/both_order_response_vo.dart';
import 'package:medical_family_app/data/vo_models/unit_instock_order_vo.dart';
part 'get_order_detail_and_invoice_response.g.dart';

@JsonSerializable()
class GetOrderDetailAndInVoiceResponse {
  @JsonKey(name: "orders")
  BothOrderResponseVO? order;

  @JsonKey(name: "units")
  List<UnitInStockOrderVO?>? units;

  @JsonKey(name: "counting_units")
  List<CountingUnitInStockOrderVO?>? countingUnits;

  @JsonKey(name: "attachs")
  List<AttachVO?>? attaches;

  @JsonKey(name: "color")
  List<String?>? color;

  @JsonKey(name: "size")
  List<String?>? size;

  GetOrderDetailAndInVoiceResponse({
    this.order,
    this.units,
    this.countingUnits,
    this.attaches,
    this.color,
    this.size,
  });

  factory GetOrderDetailAndInVoiceResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetOrderDetailAndInVoiceResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetOrderDetailAndInVoiceResponseToJson(this);
}

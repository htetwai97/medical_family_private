import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/counting_unit_id_vo.dart';
import 'package:medical_family_app/data/vo_models/item_detail_vo.dart';
part 'get_item_by_id_response.g.dart';

@JsonSerializable()
class GetItemByIdResponse {
  @JsonKey(name: "item")
  ItemDetailVO? item;

  @JsonKey(name: "counting_units")
  List<CountingUnitIdVO?>? countingUnits;

  @JsonKey(name: "counting_unit_all")
  List<CountingUnitIdVO?>? countingUnitAll;

  @JsonKey(name: "valueofinstock")
  int? valueOfInStock;

  @JsonKey(name: "valueofpreorder")
  int? valueOfPreorder;

  GetItemByIdResponse({
    this.item,
    this.countingUnits,
    this.valueOfInStock,
    this.valueOfPreorder,
    this.countingUnitAll,
  });

  factory GetItemByIdResponse.fromJson(Map<String, dynamic> json) =>
      _$GetItemByIdResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetItemByIdResponseToJson(this);

  @override
  String toString() {
    return 'GetItemByIdResponse{item: $item, countingUnits: $countingUnits, countingUnitAll: $countingUnitAll, valueOfInStock: $valueOfInStock, valueOfPreorder: $valueOfPreorder}';
  }
}

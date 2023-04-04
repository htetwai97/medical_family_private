import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/item_demo_vo.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';
part 'get_all_items_response.g.dart';
@JsonSerializable()
class GetAllItemsResponse{
  @JsonKey(name: "data")
  List<ItemDemoVO?>? data;

  @JsonKey(name: "items")
  List<ItemVO?>? items;

  GetAllItemsResponse(this.data, this.items);

  factory GetAllItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllItemsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllItemsResponseToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';
part 'get_itemlist_by_cat_and_subcat_response.g.dart';

@JsonSerializable()
class GetItemsByCatAndSubCatResponse {
  @JsonKey(name: "items")
  List<ItemVO?>? items;

  GetItemsByCatAndSubCatResponse({this.items});

  factory GetItemsByCatAndSubCatResponse.fromJson(Map<String, dynamic> json) =>
      _$GetItemsByCatAndSubCatResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetItemsByCatAndSubCatResponseToJson(this);
  @override
  String toString() {
    return 'GetItemsByCatAndSubCatResponse{items: $items}';
  }
}

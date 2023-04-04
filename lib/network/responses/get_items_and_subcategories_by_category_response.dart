import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';
import 'package:medical_family_app/data/vo_models/sub_category_vo.dart';
part 'get_items_and_subcategories_by_category_response.g.dart';

@JsonSerializable()
class GetItemsAndSubCategoriesByCategoryResponse {
  @JsonKey(name: "items")
  List<ItemVO?>? items;

  @JsonKey(name: "subs")
  List<SubCategoryVO?>? subs;

  GetItemsAndSubCategoriesByCategoryResponse({
    this.items,
    this.subs,
  });

  factory GetItemsAndSubCategoriesByCategoryResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetItemsAndSubCategoriesByCategoryResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetItemsAndSubCategoriesByCategoryResponseToJson(this);

  @override
  String toString() {
    return 'GetItemsAndSubCategoriesByCategoryResponse{items: $items, subs: $subs}';
  }
}

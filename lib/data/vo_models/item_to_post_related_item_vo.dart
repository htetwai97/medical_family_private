import 'package:json_annotation/json_annotation.dart';
part 'item_to_post_related_item_vo.g.dart';

@JsonSerializable()
class ItemToPostRelatedItemVO {
  @JsonKey(name: "item_id")
  String? itemId;

  @JsonKey(name: "category_id")
  String? categoryId;

  @JsonKey(name: "subcategory_id")
  String? subCategoryId;

  ItemToPostRelatedItemVO({
    this.itemId,
    this.categoryId,
    this.subCategoryId,
  });

  factory ItemToPostRelatedItemVO.fromJson(Map<String, dynamic> json) =>
      _$ItemToPostRelatedItemVOFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToPostRelatedItemVOToJson(this);

  @override
  String toString() {
    return 'ItemToPostRelatedItemVO{itemId: $itemId, categoryId: $categoryId, subCategoryId: $subCategoryId}';
  }
}

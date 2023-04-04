import 'package:json_annotation/json_annotation.dart';
part 'item_demo_vo.g.dart';
@JsonSerializable()
class ItemDemoVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "item_code")
  String? itemCode;

  @JsonKey(name: "item_name")
  String? itemName;

  @JsonKey(name: "customer_console")
  int? customerConsole;

  @JsonKey(name: "unit_name")
  String? unitName;

  @JsonKey(name: "category_name")
  String? categoryName;

  @JsonKey(name: "subcategory_name")
  String? subCategoryName;

  ItemDemoVO({
    this.id,
    this.itemCode,
    this.itemName,
    this.customerConsole,
    this.unitName,
    this.categoryName,
    this.subCategoryName,
  });

  factory ItemDemoVO.fromJson(Map<String, dynamic> json) =>
      _$ItemDemoVOFromJson(json);
  Map<String, dynamic> toJson() => _$ItemDemoVOToJson(this);
}

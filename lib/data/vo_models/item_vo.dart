import 'package:json_annotation/json_annotation.dart';
part 'item_vo.g.dart';

@JsonSerializable()
class ItemVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "item_code")
  String? itemCode;

  @JsonKey(name: "item_name")
  String? itemName;

  @JsonKey(name: "created_by")
  String? createdBy;

  @JsonKey(name: "customer_console")
  int? customerConsole;

  @JsonKey(name: "photo_path")
  String? photoPath;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "category_id")
  int? categoryId;

  @JsonKey(name: "sub_category_id")
  int? subCategoryId;

  @JsonKey(name: "deleted_at")
  String? deletedAt;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "unit_name")
  String? unitName;

  @JsonKey(name: "instock")
  int? inStock;

  @JsonKey(name: "preorder")
  int? preOrder;

  @JsonKey(name: "arrival_date")
  String? arrivalDate;

  @JsonKey(name: "discount_price")
  int? discountPrice;

  @JsonKey(name: "new_product_flag")
  int? newProductFlag;

  @JsonKey(name: "promotion_product_flag")
  int? promotionProductFlag;

  @JsonKey(name: "hot_sale_flag")
  int? hotSaleFlag;

  @JsonKey(name: "related_item_id")
  String? relatedItemId;

  ItemVO({
    this.id,
    this.itemCode,
    this.itemName,
    this.createdBy,
    this.customerConsole,
    this.photoPath,
    this.description,
    this.categoryId,
    this.subCategoryId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.unitName,
    this.inStock,
    this.preOrder,
    this.arrivalDate,
    this.discountPrice,
    this.newProductFlag,
    this.promotionProductFlag,
    this.hotSaleFlag,
    this.relatedItemId,
  });

  factory ItemVO.fromJson(Map<String, dynamic> json) => _$ItemVOFromJson(json);
  Map<String, dynamic> toJson() => _$ItemVOToJson(this);

  @override
  String toString() {
    return 'HotSaleOrNewArrivalItemVO{id: $id, itemCode: $itemCode, itemName: $itemName, createdBy: $createdBy, customerConsole: $customerConsole, photoPath: $photoPath, description: $description, categoryId: $categoryId, subCategoryId: $subCategoryId, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, unitName: $unitName, inStock: $inStock, preOrder: $preOrder, arrivalDate: $arrivalDate, discountPrice: $discountPrice, newProductFlag: $newProductFlag, promotionProductFlag: $promotionProductFlag, hotSaleFlag: $hotSaleFlag, relatedItemId: $relatedItemId}';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemVO _$ItemVOFromJson(Map<String, dynamic> json) => ItemVO(
      id: json['id'] as int?,
      itemCode: json['item_code'] as String?,
      itemName: json['item_name'] as String?,
      createdBy: json['created_by'] as String?,
      customerConsole: json['customer_console'] as int?,
      photoPath: json['photo_path'] as String?,
      description: json['description'] as String?,
      categoryId: json['category_id'] as int?,
      subCategoryId: json['sub_category_id'] as int?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      unitName: json['unit_name'] as String?,
      inStock: json['instock'] as int?,
      preOrder: json['preorder'] as int?,
      arrivalDate: json['arrival_date'] as String?,
      discountPrice: json['discount_price'] as int?,
      newProductFlag: json['new_product_flag'] as int?,
      promotionProductFlag: json['promotion_product_flag'] as int?,
      hotSaleFlag: json['hot_sale_flag'] as int?,
      relatedItemId: json['related_item_id'] as String?,
    );

Map<String, dynamic> _$ItemVOToJson(ItemVO instance) => <String, dynamic>{
      'id': instance.id,
      'item_code': instance.itemCode,
      'item_name': instance.itemName,
      'created_by': instance.createdBy,
      'customer_console': instance.customerConsole,
      'photo_path': instance.photoPath,
      'description': instance.description,
      'category_id': instance.categoryId,
      'sub_category_id': instance.subCategoryId,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'unit_name': instance.unitName,
      'instock': instance.inStock,
      'preorder': instance.preOrder,
      'arrival_date': instance.arrivalDate,
      'discount_price': instance.discountPrice,
      'new_product_flag': instance.newProductFlag,
      'promotion_product_flag': instance.promotionProductFlag,
      'hot_sale_flag': instance.hotSaleFlag,
      'related_item_id': instance.relatedItemId,
    };

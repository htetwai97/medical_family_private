// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_demo_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDemoVO _$ItemDemoVOFromJson(Map<String, dynamic> json) => ItemDemoVO(
      id: json['id'] as int?,
      itemCode: json['item_code'] as String?,
      itemName: json['item_name'] as String?,
      customerConsole: json['customer_console'] as int?,
      unitName: json['unit_name'] as String?,
      categoryName: json['category_name'] as String?,
      subCategoryName: json['subcategory_name'] as String?,
    );

Map<String, dynamic> _$ItemDemoVOToJson(ItemDemoVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_code': instance.itemCode,
      'item_name': instance.itemName,
      'customer_console': instance.customerConsole,
      'unit_name': instance.unitName,
      'category_name': instance.categoryName,
      'subcategory_name': instance.subCategoryName,
    };

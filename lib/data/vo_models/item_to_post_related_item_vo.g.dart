// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_to_post_related_item_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemToPostRelatedItemVO _$ItemToPostRelatedItemVOFromJson(
        Map<String, dynamic> json) =>
    ItemToPostRelatedItemVO(
      itemId: json['item_id'] as String?,
      categoryId: json['category_id'] as String?,
      subCategoryId: json['subcategory_id'] as String?,
    );

Map<String, dynamic> _$ItemToPostRelatedItemVOToJson(
        ItemToPostRelatedItemVO instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'category_id': instance.categoryId,
      'subcategory_id': instance.subCategoryId,
    };

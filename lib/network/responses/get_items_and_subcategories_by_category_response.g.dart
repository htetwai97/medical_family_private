// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_items_and_subcategories_by_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetItemsAndSubCategoriesByCategoryResponse
    _$GetItemsAndSubCategoriesByCategoryResponseFromJson(
            Map<String, dynamic> json) =>
        GetItemsAndSubCategoriesByCategoryResponse(
          items: (json['items'] as List<dynamic>?)
              ?.map((e) =>
                  e == null ? null : ItemVO.fromJson(e as Map<String, dynamic>))
              .toList(),
          subs: (json['subs'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : SubCategoryVO.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetItemsAndSubCategoriesByCategoryResponseToJson(
        GetItemsAndSubCategoriesByCategoryResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'subs': instance.subs,
    };

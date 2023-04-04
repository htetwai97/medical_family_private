// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_itemlist_by_cat_and_subcat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetItemsByCatAndSubCatResponse _$GetItemsByCatAndSubCatResponseFromJson(
        Map<String, dynamic> json) =>
    GetItemsByCatAndSubCatResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : ItemVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetItemsByCatAndSubCatResponseToJson(
        GetItemsByCatAndSubCatResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

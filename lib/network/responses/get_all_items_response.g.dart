// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllItemsResponse _$GetAllItemsResponseFromJson(Map<String, dynamic> json) =>
    GetAllItemsResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : ItemDemoVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['items'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : ItemVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllItemsResponseToJson(
        GetAllItemsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'items': instance.items,
    };

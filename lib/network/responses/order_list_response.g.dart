// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListResponse _$OrderListResponseFromJson(Map<String, dynamic> json) =>
    OrderListResponse(
      inStock: (json['instock'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BothOrderResponseVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      preOrder: (json['preorder'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BothOrderResponseVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderListResponseToJson(OrderListResponse instance) =>
    <String, dynamic>{
      'instock': instance.inStock,
      'preorder': instance.preOrder,
    };

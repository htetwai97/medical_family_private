// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_instock_order_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorInStockOrderVO _$ColorInStockOrderVOFromJson(Map<String, dynamic> json) =>
    ColorInStockOrderVO(
      id: json['id'] as int?,
      colourName: json['colour_name'] as String?,
      colourDescription: json['colour_description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      fabricId: json['fabric_id'] as int?,
      fabric: json['fabric'] == null
          ? null
          : FabricInStockOrderVO.fromJson(
              json['fabric'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ColorInStockOrderVOToJson(
        ColorInStockOrderVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'colour_name': instance.colourName,
      'colour_description': instance.colourDescription,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'fabric_id': instance.fabricId,
      'fabric': instance.fabric,
    };

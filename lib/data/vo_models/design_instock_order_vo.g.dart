// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'design_instock_order_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DesignInStockOrderVO _$DesignInStockOrderVOFromJson(
        Map<String, dynamic> json) =>
    DesignInStockOrderVO(
      id: json['id'] as int?,
      designName: json['design_name'] as String?,
      designDescription: json['design_description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$DesignInStockOrderVOToJson(
        DesignInStockOrderVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'design_name': instance.designName,
      'design_description': instance.designDescription,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

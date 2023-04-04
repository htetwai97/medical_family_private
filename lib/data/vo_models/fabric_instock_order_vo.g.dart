// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fabric_instock_order_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FabricInStockOrderVO _$FabricInStockOrderVOFromJson(
        Map<String, dynamic> json) =>
    FabricInStockOrderVO(
      id: json['id'] as int?,
      fabricName: json['fabric_name'] as String?,
      fabricDescription: json['fabric_description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$FabricInStockOrderVOToJson(
        FabricInStockOrderVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fabric_name': instance.fabricName,
      'fabric_description': instance.fabricDescription,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

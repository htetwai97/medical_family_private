// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_instock_order_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenderInStockOrderVO _$GenderInStockOrderVOFromJson(
        Map<String, dynamic> json) =>
    GenderInStockOrderVO(
      id: json['id'] as int?,
      genderName: json['gender_name'] as String?,
      genderDescription: json['gender_description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$GenderInStockOrderVOToJson(
        GenderInStockOrderVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gender_name': instance.genderName,
      'gender_description': instance.genderDescription,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

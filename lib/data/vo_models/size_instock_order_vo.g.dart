// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_instock_order_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeInStockOrderVO _$SizeInStockOrderVOFromJson(Map<String, dynamic> json) =>
    SizeInStockOrderVO(
      id: json['id'] as int?,
      sizeName: json['size_name'] as String?,
      sizeDescription: json['size_description'] as String?,
      genderId: json['gender_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      gender: json['gender'] == null
          ? null
          : GenderInStockOrderVO.fromJson(
              json['gender'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SizeInStockOrderVOToJson(SizeInStockOrderVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'size_name': instance.sizeName,
      'size_description': instance.sizeDescription,
      'gender_id': instance.genderId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'gender': instance.gender,
    };

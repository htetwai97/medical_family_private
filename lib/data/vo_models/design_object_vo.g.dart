// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'design_object_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DesignObjectVO _$DesignObjectVOFromJson(Map<String, dynamic> json) =>
    DesignObjectVO(
      id: json['id'] as int?,
      designName: json['design_name'] as String?,
      designDescription: json['design_description'] as String?,
      normalSizePrice: json['normal_size_price'] as int?,
      plusSizePrice: json['plus_size_price'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$DesignObjectVOToJson(DesignObjectVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'design_name': instance.designName,
      'design_description': instance.designDescription,
      'normal_size_price': instance.normalSizePrice,
      'plus_size_price': instance.plusSizePrice,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

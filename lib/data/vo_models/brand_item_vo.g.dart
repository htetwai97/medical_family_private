// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_item_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandItemVO _$BrandItemVOFromJson(Map<String, dynamic> json) => BrandItemVO(
      id: json['id'] as int?,
      categoryCode: json['category_code'] as String?,
      categoryName: json['category_name'] as String?,
      photoPath: json['photo_path'] as String?,
      createdBy: json['created_by'] as String?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      typeFlag: json['type_flag'] as int?,
    );

Map<String, dynamic> _$BrandItemVOToJson(BrandItemVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_code': instance.categoryCode,
      'category_name': instance.categoryName,
      'photo_path': instance.photoPath,
      'created_by': instance.createdBy,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'type_flag': instance.typeFlag,
    };

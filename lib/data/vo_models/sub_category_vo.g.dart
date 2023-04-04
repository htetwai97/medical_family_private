// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoryVO _$SubCategoryVOFromJson(Map<String, dynamic> json) =>
    SubCategoryVO(
      id: json['id'] as int?,
      subcategoryCode: json['subcategory_code'] as String?,
      name: json['name'] as String?,
      photoPath: json['photo_path'] as String?,
      categoryId: json['category_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      typeFlag: json['type_flag'] as int?,
    );

Map<String, dynamic> _$SubCategoryVOToJson(SubCategoryVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subcategory_code': instance.subcategoryCode,
      'name': instance.name,
      'photo_path': instance.photoPath,
      'category_id': instance.categoryId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'type_flag': instance.typeFlag,
    };

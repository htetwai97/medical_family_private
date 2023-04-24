// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_for_family_arrow_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorForFamilyArrowVO _$ColorForFamilyArrowVOFromJson(
        Map<String, dynamic> json) =>
    ColorForFamilyArrowVO(
      id: json['id'] as int?,
      colorName: json['colour_name'] as String?,
      colorDescription: json['colour_description'] as String?,
      fabric: json['fabric'],
    );

Map<String, dynamic> _$ColorForFamilyArrowVOToJson(
        ColorForFamilyArrowVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'colour_name': instance.colorName,
      'colour_description': instance.colorDescription,
      'fabric': instance.fabric,
    };

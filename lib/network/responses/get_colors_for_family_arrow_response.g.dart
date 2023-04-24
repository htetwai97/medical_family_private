// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_colors_for_family_arrow_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetColorsForFamilyArrowResponse _$GetColorsForFamilyArrowResponseFromJson(
        Map<String, dynamic> json) =>
    GetColorsForFamilyArrowResponse(
      colorObjects: (json['color'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ColorForFamilyArrowVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetColorsForFamilyArrowResponseToJson(
        GetColorsForFamilyArrowResponse instance) =>
    <String, dynamic>{
      'color': instance.colorObjects,
    };

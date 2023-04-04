// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'township_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TownShipVO _$TownShipVOFromJson(Map<String, dynamic> json) => TownShipVO(
      id: json['id'] as int?,
      township: json['township'] as String?,
      charges: json['charges'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$TownShipVOToJson(TownShipVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'township': instance.township,
      'charges': instance.charges,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

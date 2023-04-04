// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_item_by_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetItemByIdResponse _$GetItemByIdResponseFromJson(Map<String, dynamic> json) =>
    GetItemByIdResponse(
      item: json['item'] == null
          ? null
          : ItemDetailVO.fromJson(json['item'] as Map<String, dynamic>),
      countingUnits: (json['counting_units'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CountingUnitIdVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      valueOfInStock: json['valueofinstock'] as int?,
      valueOfPreorder: json['valueofpreorder'] as int?,
      countingUnitAll: (json['counting_unit_all'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CountingUnitIdVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetItemByIdResponseToJson(
        GetItemByIdResponse instance) =>
    <String, dynamic>{
      'item': instance.item,
      'counting_units': instance.countingUnits,
      'counting_unit_all': instance.countingUnitAll,
      'valueofinstock': instance.valueOfInStock,
      'valueofpreorder': instance.valueOfPreorder,
    };

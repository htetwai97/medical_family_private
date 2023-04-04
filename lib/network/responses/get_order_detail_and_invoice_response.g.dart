// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_order_detail_and_invoice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrderDetailAndInVoiceResponse _$GetOrderDetailAndInVoiceResponseFromJson(
        Map<String, dynamic> json) =>
    GetOrderDetailAndInVoiceResponse(
      order: json['orders'] == null
          ? null
          : BothOrderResponseVO.fromJson(
              json['orders'] as Map<String, dynamic>),
      units: (json['units'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : UnitInStockOrderVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      countingUnits: (json['counting_units'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CountingUnitInStockOrderVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      attaches: (json['attachs'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : AttachVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      color:
          (json['color'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      size: (json['size'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$GetOrderDetailAndInVoiceResponseToJson(
        GetOrderDetailAndInVoiceResponse instance) =>
    <String, dynamic>{
      'orders': instance.order,
      'units': instance.units,
      'counting_units': instance.countingUnits,
      'attachs': instance.attaches,
      'color': instance.color,
      'size': instance.size,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_save_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSaveSuccessResponse _$OrderSaveSuccessResponseFromJson(
        Map<String, dynamic> json) =>
    OrderSaveSuccessResponse(
      data: json['data'] == null
          ? null
          : BothOrderResponseVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderSaveSuccessResponseToJson(
        OrderSaveSuccessResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

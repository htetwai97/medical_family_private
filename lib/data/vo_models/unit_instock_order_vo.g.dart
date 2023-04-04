// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_instock_order_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitInStockOrderVO _$UnitInStockOrderVOFromJson(Map<String, dynamic> json) =>
    UnitInStockOrderVO(
      id: json['id'] as int?,
      orderId: json['order_id'] as int?,
      countingUnitId: json['counting_unit_id'] as int?,
      quantity: json['quantity'] as int?,
      price: json['price'] as int?,
      discountType: json['discount_type'] as String?,
      discountValue: json['discount_value'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      countingUnitInStockOrder: json['countingUnitInStockOrder'] == null
          ? null
          : CountingUnitInStockOrderVO.fromJson(
              json['countingUnitInStockOrder'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnitInStockOrderVOToJson(UnitInStockOrderVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'counting_unit_id': instance.countingUnitId,
      'quantity': instance.quantity,
      'price': instance.price,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'countingUnitInStockOrder': instance.countingUnitInStockOrder,
    };

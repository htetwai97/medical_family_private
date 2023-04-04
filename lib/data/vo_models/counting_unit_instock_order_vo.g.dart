// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counting_unit_instock_order_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountingUnitInStockOrderVO _$CountingUnitInStockOrderVOFromJson(
        Map<String, dynamic> json) =>
    CountingUnitInStockOrderVO(
      id: json['id'] as int?,
      unitCode: json['unit_code'] as String?,
      originalCode: json['original_code'] as String?,
      unitName: json['unit_name'] as String?,
      designId: json['design_id'] as int?,
      currentQuantity: json['current_quantity'] as int?,
      reorderQuantity: json['reorder_quantity'] as int?,
      resetQuantity: json['reset_quantity'] as int?,
      orderPrice: json['order_price'] as int?,
      purchasePrice: json['purchase_price'] as int?,
      itemId: json['item_id'] as int?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      orderFixedFlash: json['order_fixed_flash'] as int?,
      orderFixedPercent: json['order_fixed_percent'] as int?,
      reservedQty: json['reserved_qty'] as int?,
      fabricId: json['fabric_id'] as int?,
      colourId: json['colour_id'] as int?,
      sizeId: json['size_id'] as int?,
      genderId: json['gender_id'] as int?,
      design: json['design'] == null
          ? null
          : DesignInStockOrderVO.fromJson(
              json['design'] as Map<String, dynamic>),
      colour: json['colour'] == null
          ? null
          : ColorInStockOrderVO.fromJson(
              json['colour'] as Map<String, dynamic>),
      size: json['size'] == null
          ? null
          : SizeInStockOrderVO.fromJson(json['size'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountingUnitInStockOrderVOToJson(
        CountingUnitInStockOrderVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unit_code': instance.unitCode,
      'original_code': instance.originalCode,
      'unit_name': instance.unitName,
      'design_id': instance.designId,
      'current_quantity': instance.currentQuantity,
      'reorder_quantity': instance.reorderQuantity,
      'reset_quantity': instance.resetQuantity,
      'order_price': instance.orderPrice,
      'purchase_price': instance.purchasePrice,
      'item_id': instance.itemId,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'order_fixed_flash': instance.orderFixedFlash,
      'order_fixed_percent': instance.orderFixedPercent,
      'reserved_qty': instance.reservedQty,
      'fabric_id': instance.fabricId,
      'colour_id': instance.colourId,
      'size_id': instance.sizeId,
      'gender_id': instance.genderId,
      'design': instance.design,
      'colour': instance.colour,
      'size': instance.size,
    };

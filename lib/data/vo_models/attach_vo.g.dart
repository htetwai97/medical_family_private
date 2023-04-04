// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attach_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachVO _$AttachVOFromJson(Map<String, dynamic> json) => AttachVO(
      id: json['id'] as int?,
      orderId: json['order_id'] as int?,
      itemPhoto: json['item_photo'] as String?,
      description: json['description'] as String?,
      quantity: json['quantity'] as int?,
      price: json['price'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$AttachVOToJson(AttachVO instance) => <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'item_photo': instance.itemPhoto,
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

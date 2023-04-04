// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_preorder_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPreOrderSuccessResponse _$PostPreOrderSuccessResponseFromJson(
        Map<String, dynamic> json) =>
    PostPreOrderSuccessResponse(
      orderCode: json['order_code'] as String?,
      orderDate: json['order_date'] as String?,
      customerId: json['customer_id'] as int?,
      customerName: json['customer_name'] as String?,
      customerPhone: json['customer_phone'] as String?,
      orderType: json['order_type'] as int?,
      totalQuantity: json['total_quantity'] as int?,
      orderStatus: json['order_status'] as String?,
      deliverAddress: json['deliver_address'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
      totalAmount: json['total_amount'] as int?,
    );

Map<String, dynamic> _$PostPreOrderSuccessResponseToJson(
        PostPreOrderSuccessResponse instance) =>
    <String, dynamic>{
      'order_code': instance.orderCode,
      'order_date': instance.orderDate,
      'customer_id': instance.customerId,
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'order_type': instance.orderType,
      'total_quantity': instance.totalQuantity,
      'order_status': instance.orderStatus,
      'deliver_address': instance.deliverAddress,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
      'total_amount': instance.totalAmount,
    };

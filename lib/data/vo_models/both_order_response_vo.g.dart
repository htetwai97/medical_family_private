// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'both_order_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BothOrderResponseVO _$BothOrderResponseVOFromJson(Map<String, dynamic> json) =>
    BothOrderResponseVO(
      id: json['id'] as int?,
      orderCode: json['order_code'] as String?,
      orderDate: json['order_date'] as String?,
      customerId: json['customer_id'] as int?,
      customerName: json['customer_name'] as String?,
      customerPhone: json['customer_phone'] as String?,
      orderType: json['order_type'] as int?,
      orderStatus: json['order_status'] as String?,
      attachFlag: json['attach_flag'] as int?,
      totalQuantity: json['total_quantity'],
      totalAmount: json['total_amount'],
      deliveryFee: json['delivery_fee'] as int?,
      deliveryDate: json['delivered_date'] as String?,
      deliveredBy: json['delivered_by'] as String?,
      deliveredRemark: json['delivered_remark'] as String?,
      discountType: json['discount_type'] as String?,
      discountAmount: json['discount_amount'] as int?,
      paymentType: json['payment_type'] as String?,
      paymentChannel: json['payment_channel'] as String?,
      advance: json['advance'] as int?,
      collectAmount: json['collect_amount'] as int?,
      deliverAddress: json['deliver_address'] as String?,
      billingAddress: json['billing_address'] as String?,
      remark: json['remark'] as String?,
      status: json['status'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$BothOrderResponseVOToJson(
        BothOrderResponseVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_code': instance.orderCode,
      'order_date': instance.orderDate,
      'customer_id': instance.customerId,
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'order_type': instance.orderType,
      'order_status': instance.orderStatus,
      'attach_flag': instance.attachFlag,
      'total_quantity': instance.totalQuantity,
      'total_amount': instance.totalAmount,
      'delivery_fee': instance.deliveryFee,
      'delivered_date': instance.deliveryDate,
      'delivered_by': instance.deliveredBy,
      'delivered_remark': instance.deliveredRemark,
      'discount_type': instance.discountType,
      'discount_amount': instance.discountAmount,
      'payment_type': instance.paymentType,
      'payment_channel': instance.paymentChannel,
      'advance': instance.advance,
      'collect_amount': instance.collectAmount,
      'deliver_address': instance.deliverAddress,
      'billing_address': instance.billingAddress,
      'remark': instance.remark,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

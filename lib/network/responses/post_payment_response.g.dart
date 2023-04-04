// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPaymentResponse _$PostPaymentResponseFromJson(Map<String, dynamic> json) =>
    PostPaymentResponse(
      ecommerceOrderId: json['ecommerce_order_id'] as int?,
      screenShot: json['screenshot'] as String?,
      amount: json['amount'] as String?,
      remark: json['remark'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$PostPaymentResponseToJson(
        PostPaymentResponse instance) =>
    <String, dynamic>{
      'ecommerce_order_id': instance.ecommerceOrderId,
      'screenshot': instance.screenShot,
      'amount': instance.amount,
      'remark': instance.remark,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
    };

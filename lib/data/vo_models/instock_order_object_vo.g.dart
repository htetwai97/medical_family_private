// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instock_order_object_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InStockOrderVO _$InStockOrderVOFromJson(Map<String, dynamic> json) =>
    InStockOrderVO(
      userId: json['id'] as int?,
      userName: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      township: json['township'] as String?,
      charges: json['charges'] as int?,
      paymentType: json['paymenttype'] as String?,
      paymentChannel: json['paymentchannel'] as String?,
      remark: json['remark'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : CartItemVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      quantity: json['quantity'] as int?,
      total: json['amount'] as int?,
    );

Map<String, dynamic> _$InStockOrderVOToJson(InStockOrderVO instance) =>
    <String, dynamic>{
      'id': instance.userId,
      'name': instance.userName,
      'phone': instance.phone,
      'address': instance.address,
      'township': instance.township,
      'charges': instance.charges,
      'paymenttype': instance.paymentType,
      'paymentchannel': instance.paymentChannel,
      'remark': instance.remark,
      'products': instance.products,
      'quantity': instance.quantity,
      'amount': instance.total,
    };

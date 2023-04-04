// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_pre_order_object_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPreOrderObjectVO _$PostPreOrderObjectVOFromJson(
        Map<String, dynamic> json) =>
    PostPreOrderObjectVO(
      id: json['id'] as int?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : PreOrderItemVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$PostPreOrderObjectVOToJson(
        PostPreOrderObjectVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'orders': instance.orders,
    };

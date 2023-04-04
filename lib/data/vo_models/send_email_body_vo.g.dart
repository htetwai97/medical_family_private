// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_email_body_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendEmailBodyVO _$SendEmailBodyVOFromJson(Map<String, dynamic> json) =>
    SendEmailBodyVO(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      preOrders: (json['preorders'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : PreOrderItemVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      attaches: (json['attachs'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CustomPreOrderItemVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as int?,
    );

Map<String, dynamic> _$SendEmailBodyVOToJson(SendEmailBodyVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'email': instance.email,
      'preorders': instance.preOrders,
      'attachs': instance.attaches,
      'type': instance.type,
    };

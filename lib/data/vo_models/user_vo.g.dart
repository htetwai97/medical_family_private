// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      userName: json['username'] as String?,
      password: json['password'] as String?,
      registerDate: json['registered_date'] as String?,
      lastPurchasedDate: json['last_purchased_date'] as String?,
      totalPurchaseAmount: json['total_purchase_amount'] as int?,
      totalPurchaseTime: json['total_purchase_time'] as int?,
      totalPurchaseQuantity: json['total_purchase_qty'] as int?,
      gender: json['gender'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'username': instance.userName,
      'password': instance.password,
      'registered_date': instance.registerDate,
      'last_purchased_date': instance.lastPurchasedDate,
      'total_purchase_amount': instance.totalPurchaseAmount,
      'total_purchase_time': instance.totalPurchaseTime,
      'total_purchase_qty': instance.totalPurchaseQuantity,
      'gender': instance.gender,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

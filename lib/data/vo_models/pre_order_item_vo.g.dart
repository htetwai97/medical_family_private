// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_order_item_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreOrderItemVOAdapter extends TypeAdapter<PreOrderItemVO> {
  @override
  final int typeId = 3;

  @override
  PreOrderItemVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreOrderItemVO(
      itemName: fields[0] as String?,
      quantity: fields[1] as String?,
      price: fields[2] as String?,
      total: fields[3] as String?,
      isBrand: fields[4] as bool?,
      userId: fields[5] as String?,
      orderId: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PreOrderItemVO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.itemName)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.isBrand)
      ..writeByte(5)
      ..write(obj.userId)
      ..writeByte(6)
      ..write(obj.orderId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreOrderItemVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreOrderItemVO _$PreOrderItemVOFromJson(Map<String, dynamic> json) =>
    PreOrderItemVO(
      itemName: json['testname'] as String?,
      quantity: json['testqty'] as String?,
      price: json['price'] as String?,
      total: json['testprice'] as String?,
      isBrand: json['isBrand'] as bool?,
      userId: json['userId'] as String?,
      orderId: json['orderid'] as String?,
    );

Map<String, dynamic> _$PreOrderItemVOToJson(PreOrderItemVO instance) =>
    <String, dynamic>{
      'testname': instance.itemName,
      'testqty': instance.quantity,
      'price': instance.price,
      'testprice': instance.total,
      'isBrand': instance.isBrand,
      'userId': instance.userId,
      'orderid': instance.orderId,
    };

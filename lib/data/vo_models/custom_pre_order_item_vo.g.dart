// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_pre_order_item_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomPreOrderItemVOAdapter extends TypeAdapter<CustomPreOrderItemVO> {
  @override
  final int typeId = 4;

  @override
  CustomPreOrderItemVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomPreOrderItemVO(
      attach: fields[0] as Uint8List?,
      quantity: fields[1] as String?,
      price: fields[2] as String?,
      description: fields[3] as String?,
      totalQuantity: fields[4] as String?,
      totalAmount: fields[5] as String?,
      userId: fields[6] as String?,
      orderId: fields[7] as String?,
      timeStamp: fields[8] as String?,
      filePath: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomPreOrderItemVO obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.attach)
      ..writeByte(9)
      ..write(obj.filePath)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.totalQuantity)
      ..writeByte(5)
      ..write(obj.totalAmount)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.orderId)
      ..writeByte(8)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomPreOrderItemVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomPreOrderItemVO _$CustomPreOrderItemVOFromJson(
        Map<String, dynamic> json) =>
    CustomPreOrderItemVO(
      quantity: json['testqty'] as String?,
      price: json['testprice'] as String?,
      description: json['description'] as String?,
      totalQuantity: json['totalQuantity'] as String?,
      totalAmount: json['totalAmount'] as String?,
      userId: json['userId'] as String?,
      orderId: json['orderid'] as String?,
      timeStamp: json['timeStamp'] as String?,
      filePath: json['files'] as String?,
    );

Map<String, dynamic> _$CustomPreOrderItemVOToJson(
        CustomPreOrderItemVO instance) =>
    <String, dynamic>{
      'files': instance.filePath,
      'testqty': instance.quantity,
      'testprice': instance.price,
      'description': instance.description,
      'totalQuantity': instance.totalQuantity,
      'totalAmount': instance.totalAmount,
      'userId': instance.userId,
      'orderid': instance.orderId,
      'timeStamp': instance.timeStamp,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemVOAdapter extends TypeAdapter<CartItemVO> {
  @override
  final int typeId = 2;

  @override
  CartItemVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemVO(
      cartItemId: fields[0] as String?,
      userId: fields[1] as String?,
      itemName: fields[2] as String?,
      countingUnitId: fields[3] as int?,
      gender: fields[4] as String?,
      color: fields[5] as String?,
      fabric: fields[6] as String?,
      size: fields[7] as String?,
      updatePrice: fields[8] as int?,
      quantity: fields[9] as int?,
      itemImage: fields[10] as String?,
      unitCode: fields[11] as String?,
      price: fields[12] as int?,
      stockQuantity: fields[13] as int?,
      unitName: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemVO obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.cartItemId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.itemName)
      ..writeByte(3)
      ..write(obj.countingUnitId)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.fabric)
      ..writeByte(7)
      ..write(obj.size)
      ..writeByte(8)
      ..write(obj.updatePrice)
      ..writeByte(9)
      ..write(obj.quantity)
      ..writeByte(10)
      ..write(obj.itemImage)
      ..writeByte(11)
      ..write(obj.unitCode)
      ..writeByte(12)
      ..write(obj.price)
      ..writeByte(13)
      ..write(obj.stockQuantity)
      ..writeByte(14)
      ..write(obj.unitName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemVO _$CartItemVOFromJson(Map<String, dynamic> json) => CartItemVO(
      cartItemId: json['cartItemId'] as String?,
      userId: json['userId'] as String?,
      itemName: json['itemName'] as String?,
      countingUnitId: json['unitid'] as int?,
      gender: json['gender'] as String?,
      color: json['color'] as String?,
      fabric: json['fabric'] as String?,
      size: json['size'] as String?,
      updatePrice: json['updatePrice'] as int?,
      quantity: json['quantity'] as int?,
      itemImage: json['unitimg'] as String?,
      unitCode: json['unitcode'] as String?,
      price: json['price'] as int?,
      stockQuantity: json['stockQuantity'] as int?,
      unitName: json['unitname'] as String?,
    );

Map<String, dynamic> _$CartItemVOToJson(CartItemVO instance) =>
    <String, dynamic>{
      'cartItemId': instance.cartItemId,
      'userId': instance.userId,
      'itemName': instance.itemName,
      'unitid': instance.countingUnitId,
      'gender': instance.gender,
      'color': instance.color,
      'fabric': instance.fabric,
      'size': instance.size,
      'updatePrice': instance.updatePrice,
      'quantity': instance.quantity,
      'unitimg': instance.itemImage,
      'unitcode': instance.unitCode,
      'price': instance.price,
      'stockQuantity': instance.stockQuantity,
      'unitname': instance.unitName,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counting_unit_id_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountingUnitIdVOAdapter extends TypeAdapter<CountingUnitIdVO> {
  @override
  final int typeId = 1;

  @override
  CountingUnitIdVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountingUnitIdVO(
      id: fields[0] as int?,
      unitCode: fields[1] as String?,
      unitName: fields[2] as String?,
      designName: fields[3] as String?,
      fabricName: fields[4] as String?,
      colorName: fields[5] as String?,
      sizeName: fields[6] as String?,
      genderName: fields[7] as String?,
      currentQuantity: fields[8] as int?,
      orderPrice: fields[9] as int?,
      purchasePrice: fields[10] as int?,
      itemId: fields[11] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CountingUnitIdVO obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.unitCode)
      ..writeByte(2)
      ..write(obj.unitName)
      ..writeByte(3)
      ..write(obj.designName)
      ..writeByte(4)
      ..write(obj.fabricName)
      ..writeByte(5)
      ..write(obj.colorName)
      ..writeByte(6)
      ..write(obj.sizeName)
      ..writeByte(7)
      ..write(obj.genderName)
      ..writeByte(8)
      ..write(obj.currentQuantity)
      ..writeByte(9)
      ..write(obj.orderPrice)
      ..writeByte(10)
      ..write(obj.purchasePrice)
      ..writeByte(11)
      ..write(obj.itemId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountingUnitIdVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountingUnitIdVO _$CountingUnitIdVOFromJson(Map<String, dynamic> json) =>
    CountingUnitIdVO(
      id: json['id'] as int?,
      unitCode: json['unit_code'] as String?,
      unitName: json['unit_name'] as String?,
      designName: json['design_name'] as String?,
      fabricName: json['fabric_name'] as String?,
      colorName: json['colour_name'] as String?,
      sizeName: json['size_name'] as String?,
      genderName: json['gender_name'] as String?,
      currentQuantity: json['current_quantity'] as int?,
      orderPrice: json['order_price'] as int?,
      purchasePrice: json['purchase_price'] as int?,
      itemId: json['item_id'] as int?,
    );

Map<String, dynamic> _$CountingUnitIdVOToJson(CountingUnitIdVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unit_code': instance.unitCode,
      'unit_name': instance.unitName,
      'design_name': instance.designName,
      'fabric_name': instance.fabricName,
      'colour_name': instance.colorName,
      'size_name': instance.sizeName,
      'gender_name': instance.genderName,
      'current_quantity': instance.currentQuantity,
      'order_price': instance.orderPrice,
      'purchase_price': instance.purchasePrice,
      'item_id': instance.itemId,
    };

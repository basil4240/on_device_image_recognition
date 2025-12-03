// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cataloged_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatalogedItemAdapter extends TypeAdapter<CatalogedItem> {
  @override
  final int typeId = 0;

  @override
  CatalogedItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatalogedItem(
      imagePath: fields[0] as String,
      tag: fields[1] as String,
      notes: fields[2] as String?,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CatalogedItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.tag)
      ..writeByte(2)
      ..write(obj.notes)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatalogedItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

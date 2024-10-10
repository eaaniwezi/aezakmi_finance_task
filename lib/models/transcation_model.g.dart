// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranscationModelAdapter extends TypeAdapter<TranscationModel> {
  @override
  final int typeId = 1;

  @override
  TranscationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranscationModel(
      id: fields[0] as String,
      title: fields[1] as String,
      amount: fields[2] as double,
      timing: fields[3] as String,
      isCost: fields[4] as bool,
      selectedCategory: fields[5] as CategoryModel,
    );
  }

  @override
  void write(BinaryWriter writer, TranscationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.timing)
      ..writeByte(4)
      ..write(obj.isCost)
      ..writeByte(5)
      ..write(obj.selectedCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranscationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

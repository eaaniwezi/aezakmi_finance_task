// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalsHistoryModelAdapter extends TypeAdapter<GoalsHistoryModel> {
  @override
  final int typeId = 5;

  @override
  GoalsHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalsHistoryModel(
      date: fields[0] as String,
      amount: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, GoalsHistoryModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalsHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

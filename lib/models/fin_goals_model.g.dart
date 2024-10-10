// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fin_goals_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FinGoalsModelAdapter extends TypeAdapter<FinGoalsModel> {
  @override
  final int typeId = 4;

  @override
  FinGoalsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FinGoalsModel(
      id: fields[0] as String,
      title: fields[1] as String,
      amount: fields[2] as double,
      startDate: fields[3] as String,
      endDate: fields[4] as String,
      priority: fields[5] as double,
      history: (fields[6] as List?)?.cast<GoalsHistoryModel>(),
      percentValue: fields[7] as double?,
      totalAmountCollected: fields[8] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, FinGoalsModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.priority)
      ..writeByte(6)
      ..write(obj.history)
      ..writeByte(7)
      ..write(obj.percentValue)
      ..writeByte(8)
      ..write(obj.totalAmountCollected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinGoalsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

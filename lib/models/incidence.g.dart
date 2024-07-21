// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incidence.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncidenceAdapter extends TypeAdapter<Incidence> {
  @override
  final int typeId = 0;

  @override
  Incidence read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Incidence()
      ..title = fields[0] as String
      ..date = fields[1] as DateTime
      ..description = fields[2] as String
      ..photoPath = fields[3] as String
      ..audioPath = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Incidence obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.photoPath)
      ..writeByte(4)
      ..write(obj.audioPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncidenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

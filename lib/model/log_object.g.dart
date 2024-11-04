// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogObjectAdapter extends TypeAdapter<LogObject> {
  @override
  final int typeId = 0;

  @override
  LogObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogObject()
      ..feature = fields[0] as String?
      ..log = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, LogObject obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.feature)
      ..writeByte(1)
      ..write(obj.log);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_save.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionSaveAdapter extends TypeAdapter<SessionSave> {
  @override
  final int typeId = 0;

  @override
  SessionSave read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionSave(
      name: fields[0] as String,
      time: fields[1] as String,
      place: fields[2] as String,
      latlng: (fields[3] as List).cast<LatLng>(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionSave obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.place)
      ..writeByte(3)
      ..write(obj.latlng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionSaveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

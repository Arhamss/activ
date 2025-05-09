// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'happiness_level_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HappinessLevelAdapter extends TypeAdapter<HappinessLevel> {
  @override
  final int typeId = 1;

  @override
  HappinessLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return HappinessLevel.excellent;
      case 1:
        return HappinessLevel.good;
      case 2:
        return HappinessLevel.fair;
      case 3:
        return HappinessLevel.poor;
      case 4:
        return HappinessLevel.worst;
      default:
        return HappinessLevel.excellent;
    }
  }

  @override
  void write(BinaryWriter writer, HappinessLevel obj) {
    switch (obj) {
      case HappinessLevel.excellent:
        writer.writeByte(0);
        break;
      case HappinessLevel.good:
        writer.writeByte(1);
        break;
      case HappinessLevel.fair:
        writer.writeByte(2);
        break;
      case HappinessLevel.poor:
        writer.writeByte(3);
        break;
      case HappinessLevel.worst:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HappinessLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

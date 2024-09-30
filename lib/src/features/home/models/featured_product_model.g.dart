// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeaturedProductModelAdapter extends TypeAdapter<FeaturedProductModel> {
  @override
  final int typeId = 0;

  @override
  FeaturedProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeaturedProductModel(
      name: fields[0] as String,
      price: fields[1] as String,
      imageUrl: fields[3] as String,
      oldPrice: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FeaturedProductModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.oldPrice)
      ..writeByte(3)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeaturedProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

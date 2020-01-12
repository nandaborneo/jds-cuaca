// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel(
    json['id'] as int,
    json['name'] as String,
    json['country'] as String,
    json['timezone'] as int,
  );
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'timezone': instance.timezone,
    };

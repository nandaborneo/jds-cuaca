import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()

class CityModel {
  CityModel(this.id,this.name,this.country,this.timezone);

  int id;
  String name;
  String country;
  int timezone;

  factory CityModel.fromJson(Map<String,dynamic> json) => _$CityModelFromJson(json);

  Map<String,dynamic> toJson() => _$CityModelToJson(this);
}
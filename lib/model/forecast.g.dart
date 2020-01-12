// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastModel _$ForecastModelFromJson(Map<String, dynamic> json) {
  return ForecastModel(
    json['dt'] as int,
    json['dt_txt'] as String,
    json['main'] == null
        ? null
        : Main.fromJson(json['main'] as Map<String, dynamic>),
    json['weather'] == null
        ? null
        : Weather.fromJson(json['weather'][0] as Map<String, dynamic>),
    json['clouds'] == null
        ? null
        : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
    json['wind'] == null
        ? null
        : Wind.fromJson(json['wind'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ForecastModelToJson(ForecastModel instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'dt_txt': instance.dtTxt,
      'main': instance.main?.toJson(),
      'weather': instance.weather?.toJson(),
      'clouds': instance.clouds?.toJson(),
      'wind': instance.wind?.toJson(),
    };

Main _$MainFromJson(Map<String, dynamic> json) {
  return Main(
    (json['temp'] as num)?.toDouble(),
    (json['temp_min'] as num)?.toDouble(),
    (json['temp_max'] as num)?.toDouble(),
    (json['humidity'] as num)?.toDouble(),
    (json['pressure'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    json['id'] as int,
    json['main'] as String,
    json['description'] as String,
    json['icon'] as String,
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

Clouds _$CloudsFromJson(Map<String, dynamic> json) {
  return Clouds(
    json['all'] as int,
  );
}

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
      'all': instance.all,
    };

Wind _$WindFromJson(Map<String, dynamic> json) {
  return Wind(
    (json['speed'] as num)?.toDouble(),
    json['deg'] as int,
  );
}

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
    };

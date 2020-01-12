import 'dart:convert';

import 'package:cuaca/helper/api.dart';
import 'package:cuaca/helper/linkhelper.dart';
import 'package:cuaca/helper/session.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast.g.dart';

@JsonSerializable(explicitToJson: true)
class ForecastModel {
  ForecastModel(
      this.dt, this.dtTxt, this.main, this.weather, this.clouds, this.wind);

  int dt;
  @JsonKey(name: 'dt_txt')
  String dtTxt;
  Main main;
  Weather weather;
  Clouds clouds;
  Wind wind;

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);

  static Future getDataForecast() async {
    String cityId =await Session.getCityId();
    return await Api.httpGet(LinkHelper.forecastGet+"?id="+cityId).then((value) {
      var response = json.decode(value);
      if (response['cod'] == "200") {
        return response;
      } else {}
    }).whenComplete(() {});
  }
}

@JsonSerializable()
class Main {
  Main(this.temp, this.tempMin, this.tempMax, this.humidity, this.pressure);
  double temp;
  @JsonKey(name: 'temp_min')
  double tempMin;
  @JsonKey(name: 'temp_max')
  double tempMax;
  double humidity;
  double pressure;

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Weather {
  Weather(this.id, this.main, this.description, this.icon);

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Clouds {
  Clouds(this.all);

  int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Wind {
  Wind(this.speed, this.deg);
  double speed;
  int deg;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

import 'dart:convert';

import 'package:cuaca/helper/api.dart';
import 'package:cuaca/helper/linkhelper.dart';
import 'package:cuaca/helper/session.dart';
import 'package:cuaca/model/city.dart';
import 'package:cuaca/model/forecast.dart';
import 'package:cuaca/pages/frontpage/frontpage.dart';
import 'package:cuaca/pages/globalwidget/backgrounddaynight.dart';
import 'package:cuaca/pages/homepage/widget/listforecast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../apptheme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _dayStatus = true;
  String _greet = "";
  String _cityid;
  bool _isLoading = false;
  List<dynamic> _forecast;
  ForecastModel _firstData;
  CityModel _cityModel;
  static DateFormat _timeFormat = DateFormat.Hm();
  static DateFormat _dateFormat = DateFormat("yyyy-MM-dd");
  DateTime _currentDate = _timeFormat.parse(_timeFormat.format(DateTime.now()));
  String _dayCompare;

  @override
  void initState() {
    super.initState();
    String sapaan;
    if (_currentDate.isAfter(_timeFormat.parse("04:00")) &&
        _currentDate.isBefore(_timeFormat.parse("10:00"))) {
      sapaan = "Selamat Pagi, ";
    } else if (_currentDate.isAfter(_timeFormat.parse("10:00")) &&
        _currentDate.isBefore(_timeFormat.parse("14:00"))) {
      sapaan = "Selamat Siang, ";
    } else if (_currentDate.isAfter(_timeFormat.parse("14:00")) &&
        _currentDate.isBefore(_timeFormat.parse("18:30"))) {
      sapaan = "Selamat Sore, ";
    } else if (_currentDate.isAfter(_timeFormat.parse("18:30")) &&
        _currentDate.isBefore(_timeFormat.parse("24:00"))) {
      sapaan = "Selamat Malam, ";
    } else if (_currentDate.isAfter(_timeFormat.parse("01:00")) &&
        _currentDate.isBefore(_timeFormat.parse("04:00"))) {
      sapaan = "Selamat Malam, ";
    }
    setState(() {
      _dayStatus = _currentDate.isAfter(_timeFormat.parse("06:00")) &&
          _currentDate.isBefore(_timeFormat.parse("18:00"));
    });
    _setInfo(sapaan);
    _getForecast();
  }

  _setInfo(sapaan) async {
    String username = await Session.getUsername();
    String cityId = await Session.getCityId();

    setState(() {
      _cityid = cityId;
      _greet = sapaan + username;
    });
  }

  _getForecast() async {
    Map<String, dynamic> value = await ForecastModel.getDataForecast();
    setState(() {
      _forecast = value["list"];
      _firstData = ForecastModel.fromJson(_forecast[0]);
      _cityModel = CityModel.fromJson(value["city"]);
      //  print(_cityModel.name);
    });
  }

  _logout(context) async {
    await Session.setCityId(null);
    await Session.setUsername(null);
    await Session.setZipCode(null);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FrontPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackgroundGradientDayNight(
          dayStatus: _dayStatus,
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(_greet),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.refresh),
                    tooltip: "Logout",
                    onPressed: () => _getForecast()),
                IconButton(
                    icon: Icon(Icons.exit_to_app),
                    tooltip: "Logout",
                    onPressed: () => _logout(context)),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppTheme.cardNearTransparent),
                                padding: EdgeInsets.only(
                                    left: 8, top: 4, bottom: 4, right: 8),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _cityModel == null
                                            ? "Loading"
                                            : _cityModel.name,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                _firstData == null
                                    ? "Loading"
                                    : _firstData.main.temp.round().toString() +
                                        "\u00B0",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Center(
                              child: Text(
                                _firstData == null
                                    ? "Loading"
                                    : _firstData.main.tempMax
                                            .round()
                                            .toString() +
                                        "\u00B0/" +
                                        (_firstData == null
                                            ? "Loading"
                                            : _firstData.main.tempMin
                                                .round()
                                                .toString()) +
                                        "\u00B0",
                                style: TextStyle(
                                    color: _dayStatus
                                        ? AppTheme.secondaryDayText
                                        : AppTheme.secondaryNightText,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          _firstData == null
                              ? Icon(Icons.filter_drama)
                              : Image.network(LinkHelper.iconUrl +
                                  _firstData.weather.icon +
                                  "@2x.png"),
                          Text(
                              _firstData == null
                                  ? "Loading"
                                  : _firstData.weather.description,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16))
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.opacity,
                                    size: 34,
                                    color: _dayStatus
                                        ? AppTheme.secondaryDayText
                                        : AppTheme.secondaryNightText),
                                Text(
                                    _firstData == null
                                        ? "Loading"
                                        : _firstData.main.humidity.toString() +
                                            "%",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text("Kelembapan",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: _dayStatus
                                            ? AppTheme.secondaryDayText
                                            : AppTheme.darkerText,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.toys,
                                    size: 34,
                                    color: _dayStatus
                                        ? AppTheme.secondaryDayText
                                        : AppTheme.secondaryNightText),
                                Text(
                                    _firstData == null
                                        ? "Loading"
                                        : _firstData.wind.speed.toString() +
                                            " m/s",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text("Angin",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: _dayStatus
                                            ? AppTheme.secondaryDayText
                                            : AppTheme.darkerText,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.shutter_speed,
                                    size: 34,
                                    color: _dayStatus
                                        ? AppTheme.secondaryDayText
                                        : AppTheme.secondaryNightText),
                                Text(
                                    _firstData == null
                                        ? "Loading"
                                        : _firstData.main.pressure.toString() +
                                            " hpa",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text("Tekanan",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: _dayStatus
                                            ? AppTheme.secondaryDayText
                                            : AppTheme.darkerText,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.wb_cloudy,
                                    size: 34,
                                    color: _dayStatus
                                        ? AppTheme.secondaryDayText
                                        : AppTheme.secondaryNightText),
                                Text(
                                    _firstData == null
                                        ? "Loading"
                                        : _firstData.clouds.all.toString() +
                                            "%",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text("Mendung",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: _dayStatus
                                            ? AppTheme.secondaryDayText
                                            : AppTheme.darkerText,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: ListView.builder(
                    itemCount: _forecast != null ? _forecast.length : 1,
                    itemBuilder: (context, index) {
                      if (_forecast != null) {
                        ForecastModel _modelData =
                            ForecastModel.fromJson(_forecast[index]);
                        if (_dateFormat.parse(_modelData.dtTxt).compareTo(
                                    _dateFormat.parse(
                                        _dateFormat.format(DateTime.now().toUtc()))) !=
                                0 &&
                            _dateFormat.parse(_modelData.dtTxt).compareTo(
                                    _dateFormat.parse(_dayCompare!=null ? _dayCompare:"1970-01-01")) !=
                                0) {
                          _dayCompare =
                              _dateFormat.parse(_modelData.dtTxt).toString();
                          
                          return ListForecast(forecastModel: _modelData,isDay: _dayStatus,);
                        }
                      }
                      return _forecast == null
                          ? Center(
                              child: Text(
                              "Load Data",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ))
                          : Container();
                    },
                  ),
                ))
              ],
            ),
          ),
        )
      ],
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cuaca/helper/linkhelper.dart';
import 'package:cuaca/model/forecast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../apptheme.dart';

class ListForecast extends StatelessWidget {
  const ListForecast({this.forecastModel, this.isDay, Key key})
      : super(key: key);
  final ForecastModel forecastModel;
  final bool isDay;

  @override
  Widget build(BuildContext context) {
    String date =
        DateFormat("d-MMM").format(DateTime.parse(forecastModel.dtTxt));
    String day = DateFormat("EEEE").format(DateTime.parse(forecastModel.dtTxt));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(day, style: TextStyle(color: Colors.white, fontSize: 16)),
                Text(
                  date,
                  style: TextStyle(
                      color: isDay
                          ? AppTheme.secondaryDayText
                          : AppTheme.secondaryNightText,
                      fontSize: 13),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.network(
              LinkHelper.iconUrl + forecastModel.weather.icon + "@2x.png",
              height: 48,
            ),
          ),
          Expanded(
            child: Text(forecastModel.weather.description,
                style: TextStyle(
                    color: isDay
                        ? AppTheme.secondaryDayText
                        : AppTheme.secondaryNightText)),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  forecastModel.main.temp.round().toString() + "\u00B0",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

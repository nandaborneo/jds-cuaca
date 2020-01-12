import 'package:cuaca/helper/session.dart';
import 'package:cuaca/pages/frontpage/frontpage.dart';
import 'package:cuaca/pages/globalwidget/backgrounddaynight.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _dayStatus = true;
  String _greet = "";
  String _cityid;

  @override
  void initState() {
    super.initState();
    DateFormat _dateFormat = DateFormat.Hm();
    DateTime _currentDate =
        _dateFormat.parse(_dateFormat.format(DateTime.now()));
    String sapaan;
    if (_currentDate.isAfter(_dateFormat.parse("04:00")) &&
        _currentDate.isBefore(_dateFormat.parse("10:00"))) {
      sapaan = "Selamat Pagi, ";
    } else if (_currentDate.isAfter(_dateFormat.parse("10:00")) &&
        _currentDate.isBefore(_dateFormat.parse("14:00"))) {
      sapaan = "Selamat Siang, ";
    } else if (_currentDate.isAfter(_dateFormat.parse("14:00")) &&
        _currentDate.isBefore(_dateFormat.parse("18:30"))) {
      sapaan = "Selamat Sore, ";
    } else if (_currentDate.isAfter(_dateFormat.parse("18:30")) &&
        _currentDate.isBefore(_dateFormat.parse("04:00"))) {
      sapaan = "Selamat Malam, ";
    }
    setState(() {
      _dayStatus = _currentDate.isAfter(_dateFormat.parse("06:00")) &&
          _currentDate.isBefore(_dateFormat.parse("18:00"));
    });
    _setInfo(sapaan);
  }

  _setInfo(sapaan) async {
    String username = await Session.getUsername();
    String cityId =await Session.getCityId();

    setState(() {
       _cityid =cityId;
       _greet =sapaan+username;
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
                    icon: Icon(Icons.exit_to_app),
                    tooltip: "Logout",
                    onPressed: () => _logout(context)),
              ],
            ),
          ),
        )
      ],
    );
  }
}

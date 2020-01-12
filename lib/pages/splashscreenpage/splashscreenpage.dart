import 'package:cuaca/helper/session.dart';
import 'package:cuaca/pages/frontpage/frontpage.dart';
import 'package:cuaca/pages/globalwidget/backgrounddaynight.dart';
import 'package:cuaca/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool _dayStatus = true;

  
  @override
  void initState() {
    super.initState();
    DateFormat _dateFormat = DateFormat.Hm();
    DateTime _currentDate =
        _dateFormat.parse(_dateFormat.format(DateTime.now()));
    setState(() {
      _dayStatus = _currentDate.isAfter(_dateFormat.parse("06:00")) &&
          _currentDate.isBefore(_dateFormat.parse("18:00"));
    });
    _checkSession();
  }
  _checkSession() async{
    final String username = await Session.getUsername();
    Future.delayed(Duration(seconds: 2), () {
      if (username == null || username == "") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return FrontPage();
        }));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackgroundGradientDayNight(
          dayStatus: _dayStatus,
        ),
        Center(
          child: Container(
              color: Colors.transparent,
              child: Image.asset("assets/image/launcher.png",height: 128,)),
        ),
      ],
    );
  }
}

import 'package:cuaca/pages/splashscreenpage/splashscreenpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() {
  Stetho.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: SplashScreenPage(),
    );
  }
}
import 'dart:convert';

import 'package:cuaca/helper/api.dart';
import 'package:cuaca/helper/linkhelper.dart';
import 'package:cuaca/helper/session.dart';
import 'package:cuaca/pages/globalwidget/backgrounddaynight.dart';
import 'package:cuaca/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cuaca/model/city.dart';

import '../../apptheme.dart';

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  bool _dayStatus = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _indexTab = 0;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _namaKotaController = new TextEditingController();
  TextEditingController _kodePosController = new TextEditingController();

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
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        _isLoading = true;
      });
      String userName = _userNameController.text;
      String kodePos = _kodePosController.text;
      String namaKota = _namaKotaController.text;
      String param = _indexTab == 0 ? '?zip=$kodePos,id' : '?q=$namaKota,id';

      Api.httpGet(LinkHelper.forecastGet + param).then((value) {
        var responseBody = json.decode(value);
        if (responseBody['cod'] == "200") {
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Kota Ditemukan Silahkan Tunggu"),
          ));
          CityModel cityModel = CityModel.fromJson(responseBody["city"]);
          Session.setUsername(userName);
          Session.setCityId(cityModel.id.toString());
          if (_indexTab == 0) {
            Session.setZipCode(kodePos);
          }
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          });
        } else {
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(responseBody['message']),
          ));
        }
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQuery = MediaQuery.of(context);
    return Stack(
      children: <Widget>[
        BackgroundGradientDayNight(
          dayStatus: _dayStatus,
        ),
        Positioned(
          right:-150,
          top: -150,
          child: Container(
            child: Image.network(
              LinkHelper.iconUrl + (_dayStatus ? "01d" : "01n") + "@2x.png",fit: BoxFit.fill,
              height: 400,
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(64.0),
                  child: Text("Cuaca Indonesia",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 24,),),
                ),
                SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: _mediaQuery.viewInsets.bottom),
                    child: DefaultTabController(
                      length: 2,
                      child: Form(
                        key: _formKey,
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  elevation: 0,
                                  color: AppTheme.cardNearTransparent,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 16,
                                            left: 8,
                                            right: 8,
                                            bottom: 8),
                                        child: TextFormField(
                                          controller: _userNameController,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                              hintText:
                                                  "Masukkan Nama Pengguna",
                                              hintStyle: TextStyle(
                                                  color: Colors.white),
                                              prefixIcon: Container(
                                                  child: IconTheme(
                                                data: IconThemeData(
                                                    color: Colors.white),
                                                child: Icon(Icons.person),
                                              )),
                                              border: InputBorder.none),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Nama Pengguna Harus Di isi";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color:
                                                AppTheme.tabBarNearTransparent,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        width: 230,
                                        height: 30,
                                        child: TabBar(
                                            onTap: (index) {
                                              setState(() {
                                                _indexTab = index;
                                              });
                                            },
                                            unselectedLabelColor: Colors.white,
                                            indicatorSize:
                                                TabBarIndicatorSize.tab,
                                            indicator: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: _dayStatus
                                                    ? AppTheme.dayStartGradient
                                                    : AppTheme
                                                        .nightStartGradient),
                                            tabs: [
                                              Tab(
                                                child: Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text("Kode POS"),
                                                  ),
                                                ),
                                              ),
                                              Tab(
                                                child: Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                          color: Colors
                                                              .transparent)),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text("Nama Kota"),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      Container(
                                        height: _mediaQuery.size.height * 0.08,
                                        child: TabBarView(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: TextFormField(
                                                controller: _kodePosController,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Masukkan Kode Pos",
                                                    hintStyle: TextStyle(
                                                        color: Colors.white),
                                                    prefixIcon: Container(
                                                        child: IconTheme(
                                                      data: IconThemeData(
                                                          color: Colors.white),
                                                      child: Icon(
                                                          Icons.location_on),
                                                    )),
                                                    border: InputBorder.none),
                                                validator: (value) {
                                                  if (_indexTab == 0) {
                                                    if (value.isEmpty) {
                                                      return "Kode Pos Harus Di isi";
                                                    }
                                                  }

                                                  return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: TextFormField(
                                                controller: _namaKotaController,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Masukkan Nama Kota",
                                                    hintStyle: TextStyle(
                                                        color: Colors.white),
                                                    prefixIcon: Container(
                                                        child: IconTheme(
                                                      data: IconThemeData(
                                                          color: Colors.white),
                                                      child: Icon(
                                                          Icons.location_city),
                                                    )),
                                                    border: InputBorder.none),
                                                validator: (value) {
                                                  if (_indexTab == 1) {
                                                    if (value.isEmpty) {
                                                      return "Nama Kota Harus Di isi";
                                                    }
                                                  }

                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 32,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 30,
                              left: 30,
                              child: _isLoading
                                  ? Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : RaisedButton(
                                      child: Text("Proses",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      color: _dayStatus
                                          ? AppTheme.dayEndGradient
                                          : AppTheme.nightEndGradient,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      onPressed: _submit,
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

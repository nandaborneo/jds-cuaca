import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static final String _appId = '&units=metric&lang=id&appid=82d36c38ee6989be0a7818d5648a1d64';
  static Future<String> httpPost(
      String serviceName, [Map<String, dynamic> data]) async {
    var responseBody = '{"cod":"500","message":"Kesalahan Tidak Diketahui","cnt":0,"list":[]}';

    try {
      var response = await http.post('$serviceName$_appId',
          headers: {
            'Accept': 'application/json',
            // 'Content-Type': 'application/json'
          },
          body: data);
      if (response.statusCode == 200) {
        responseBody = response.body;
      }
    } catch (e) {
      print("api"+e.toString());
       throw new Exception("HTTP POST ERROR");
    }

    return responseBody;
  }

  static Future<String> httpGet(String serviceName) async {
    var responseBody = '{"cod":"500","message":"Kesalahan Tidak Diketahui","cnt":0,"list":[]}';
    try {
      var response = await http.get(
        '$serviceName$_appId',
        headers: {
          'Accept': 'application/json',
          // 'Content-Type': 'application/json'
        },
      );
      print('$serviceName$_appId');

      if (response.statusCode == 200) {
        responseBody = response.body;
      }
      if (json.decode(response.body)["cod"] == "404") {
        responseBody = '{"cod":"404","message":"Kota Tidak Ditemukan"}';
      }
    } catch (e) {
      throw new Exception("HTTP GET ERROR");
    }

    return responseBody;
  }
}

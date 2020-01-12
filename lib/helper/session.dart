import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  static Future<bool> setUsername(String username) async {
    final SharedPreferences preferences = await _prefs;
    return preferences.setString("username", username);
  }

  static Future<String> getUsername() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("username");
  }

  static Future<bool> setZipCode(String zipCode) async {
    final SharedPreferences preferences = await _prefs;
    return preferences.setString("zip_code", zipCode);
  }

  static Future<String> getZipCode() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("zip_code");
  }

  static Future<bool> setCityId(String cityId) async {
    final SharedPreferences preferences = await _prefs;
    return preferences.setString("city_id", cityId);
  }

  static Future<String> getCityId() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("city_id");
  }
  
}

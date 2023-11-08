import 'package:shared_preferences/shared_preferences.dart';

class SystemInfo {
  static SharedPreferences? _prefs;

  // Initialize shared preferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setUid(int uid) {
    _prefs?.setInt('uid', uid);
  }

  static void removeUID() {
    _prefs?.remove('uid');
  }

  static int? get getUid {
    return _prefs?.getInt('uid');
  }

  static bool? get getIsOwner {
    return _prefs?.getBool("owner");
  }

  static void setIsOwner(bool data) {
    _prefs?.setBool("owner", data);
  }

  static void removeIsOwner() {
    _prefs?.remove("owner");
  }

  static bool? get getIsBusinessProfile {
    return _prefs?.getBool("businessProfile");
  }

  static void setIsBusinessProfile(bool data) {
    _prefs?.setBool("businessProfile", data);
  }

  static void removeIsBusinessProfile() {
    _prefs?.remove("businessProfile");
  }

  static String? get getToken {
    return _prefs?.getString("token");
  }

  static void setToken(String data) {
    _prefs?.setString("token", data);
  }

  static void removeToken() {
    _prefs?.remove("token");
  }

  static String? get geDBName {
    return _prefs?.getString("db");
  }

  static void setDBName(String data) {
    _prefs?.setString("db", data);
  }

  static void removeDBName() {
    _prefs?.remove("db");
  }
}

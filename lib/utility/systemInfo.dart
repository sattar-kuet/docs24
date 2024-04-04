import 'package:mailbox/main.dart';

class SystemInfo {
  static void setUid(int uid) => prefs.setInt('uid', uid);
  static void removeUID() => prefs.remove('uid');
  static int? get getUid => prefs.getInt('uid');

  static bool? get getIsOwner => prefs.getBool("owner");
  static void setIsOwner(bool data) => prefs.setBool("owner", data);
  static void removeIsOwner() => prefs.remove("owner");

  static bool? get getIsBusinessProfile => prefs.getBool("businessProfile");
  static void setIsBusinessProfile(bool data) =>
      prefs.setBool("businessProfile", data);
  static void removeIsBusinessProfile() => prefs.remove("businessProfile ");

  static String? get getToken => prefs.getString("token");
  static void setToken(String data) => prefs.setString("token", data);
  static void removeToken() => prefs.remove("token");

  static String? get geDBName => prefs.getString("db");
  static void setDBName(String data) => prefs.setString("db", data);
  static void removeDBName() => prefs.remove("db");
}

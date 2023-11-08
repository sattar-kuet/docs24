import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  // Initialize shared preferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setSendMailDate(String date) {
    _prefs?.setString('send_mail_date', date);
  }

  static void removeSendMailDate() {
    _prefs?.remove('send_mail_date');
  }

  static String? get getSendMailDate {
    return _prefs?.getString('send_mail_date');
  }
}

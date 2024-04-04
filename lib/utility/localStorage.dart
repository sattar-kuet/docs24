import 'package:mailbox/main.dart';

class LocalStorage {
  static void setSendMailDate(String date) =>
      prefs.setString('send_mail_date', date);
  static void removeSendMailDate() => prefs.remove('send_mail_date');
  static String? get getSendMailDate => prefs.getString('send_mail_date');
}

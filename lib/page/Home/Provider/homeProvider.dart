import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mailbox/page/Home/Model/emailLog.dart';
import 'package:mailbox/utility/APIRoot.dart';
import 'package:mailbox/utility/systemInfo.dart';

class HomeProvider extends ChangeNotifier {
  List<EmailLogModel> _emailLog = [];
  List<EmailLogModel> get emailLog => _emailLog;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void getEmailLog() async {
    _isLoading = true;
    final response = await ApiRoot.request(
      {
        "uid": SystemInfo.getUid,
      },
      url: "email/log",
    );
    print(response.body);
    if (response.statusCode == 200) {
      _emailLog = (json.decode(response.body)['result']['logs'] as List)
          .map((e) => EmailLogModel.fromJson(e))
          .toList();
    }
    _isLoading = false;
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:docs24/repository/account_status.dart';
import 'package:docs24/utility/APIRoot.dart';
import 'package:docs24/utility/systemInfo.dart';

class WelcomeProvider extends ChangeNotifier {
  void dbNameAction() {
    SystemInfo.setDBName('app_db');
  }

  void loginStatusCheckAction(BuildContext context) async {
    if (SystemInfo.getToken != null) {
      http.Response response = await ApiRoot.request(
        {},
        url: 'session/check',
        isEmpty: true,
      );
      final sessionResponse = json.decode(response.body)['result'];

      if (sessionResponse['status'] == true) {
        Navigator.of(context).pushReplacementNamed('/emailLog');
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      });
    }
  }

  Future<bool> profileStateCheckAction() async {
    http.Response response = await ApiRoot.request(
      {
        "uid": SystemInfo.getUid,
      },
      url: 'client/profile/status',
    );

    final body = json.decode(response.body)['result'];
    return body['is_complete'];
  }
}

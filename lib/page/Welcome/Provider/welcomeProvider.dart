import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:docs24/repository/account_status.dart';
import 'package:docs24/utility/APIRoot.dart';
import 'package:docs24/utility/systemInfo.dart';

class WelcomeProvider extends ChangeNotifier {
  void dbNameAction() {
    // http.Response response =
    //     await ApiRoot.request({}, url: 'db_name', isEmpty: true);
    // final body = json.decode(response.body)['result'];
    // if (body['status'] == true) {
    // debugPrint("----- DB name get data -----");
    SystemInfo.setDBName('app_db');
    // }
  }

  // void loginStatusCheckAction(BuildContext context) async {
  //   Navigator.of(context).pushNamedAndRemoveUntil(
  //     '/login',
  //     (route) => false,
  //   );
  // }

  void loginStatusCheckAction(BuildContext context) async {
    if (SystemInfo.getToken != null) {
      http.Response response = await ApiRoot.request(
        {},
        url: 'session/check',
        isEmpty: true,
      );
      final body = json.decode(response.body)['result'];

      if (body['status'] == true) {
        dynamic profileStatus = await AccountStatus.userStateCheckAction();
        if (profileStatus['is_business_account'] == false) {
          if (profileStatus['is_complete']) {
            Future.delayed(
              const Duration(seconds: 0),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (route) => false,
              ),
            );
          } else {
            Future.delayed(
              const Duration(seconds: 0),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/extendedProfile',
                (route) => false,
              ),
            );
          }
        } else if (profileStatus['is_complete']) {
          if (profileStatus['status'] == "approved") {
            Future.delayed(
              const Duration(seconds: 0),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (route) => false,
              ),
            );
          } else if (profileStatus['status'] == "email_verification_pending") {
            Future.delayed(
              const Duration(seconds: 0),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (route) => false,
              ),
            );
          } else {
            Future.delayed(
              const Duration(seconds: 0),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/message',
                (route) => false,
              ),
            );
          }
        } else {
          Future.delayed(
            const Duration(seconds: 0),
            () => Navigator.of(context).pushNamedAndRemoveUntil(
              '/businessProfile',
              (route) => false,
            ),
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
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

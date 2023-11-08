// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:docs24/repository/account_status.dart';
import 'package:docs24/utility/APIRoot.dart';
import 'package:docs24/utility/systemInfo.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isbtnEnable = false;
  bool get isbtnEnabl => _isbtnEnable;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void btnEnableAction() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      _isbtnEnable = true;
      notifyListeners();
    } else {
      _isbtnEnable = false;
      notifyListeners();
    }
  }

  void loginAction(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    http.Response response = await ApiRoot.request(
      {
        "db": SystemInfo.geDBName,
        "login": email,
        "password": password,
      },
      url: 'web/session/authenticate',
      rooturl: true,
    );
    

    final responseBody = json.decode(response.body);
    if (responseBody.containsKey('error')) {
      Fluttertoast.showToast(
        msg: 'Wrong Credential',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      final body = responseBody['result'];
      SystemInfo.setToken(response.headers['set-cookie'].cookieFilter);
      SystemInfo.setUid(body['uid']);
      dynamic profileStatus = await AccountStatus.userStateCheckAction();
      bool isComplete = profileStatus['is_complete'];
      bool isBusinessAccount = profileStatus['is_business_account'];
      SystemInfo.setIsBusinessProfile(isBusinessAccount);

      if (isBusinessAccount == false) {
        final routeName = isComplete ? '/' : '/extendedProfile';
        Navigator.of(context).pushNamedAndRemoveUntil(
          routeName,
          (route) => false,
        );
      } else if (isComplete) {
        if (profileStatus['status'] == "approved") {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/',
            (route) => false,
          );
        } else if (profileStatus['status'] == "email_verification_pending") {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/verifyemail",
            arguments: {
              "email": emailController.value.text,
              "password": passwordController.value.text
            },
            (route) => false,
          );
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/message',
            (route) => false,
          );
        }
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/businessProfile',
          (route) => false,
        );
      }
      http.Response isOwnerResponse = await ApiRoot.request(
        {},
        url: 'user/is_owner',
        isEmpty: true,
      );

      final isOwnerResponseBody = json.decode(isOwnerResponse.body);
      print(isOwnerResponseBody);
      final isOwner = isOwnerResponseBody['result']['is_owner'];
      SystemInfo.setIsOwner(isOwner);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> profileStateCheckAction() async {
    http.Response response = await ApiRoot.request(
      {
        "uid": SystemInfo.getUid,
      },
      url: 'client/profile/status',
    );

    final responseBody = json.decode(response.body)['result'];
    return responseBody['is_complete'];
  }
}

extension SystemSetting on dynamic {
  String get cookieFilter {
    // filter Response Header Cookie
    return ((this as String).split(';')[0]).split("=")[1];
  }
}

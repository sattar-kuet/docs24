// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mailbox/utility/APIRoot.dart';

class PasswordRecoveryProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isbtnEnable = false;
  bool get isbtnEnabl => _isbtnEnable;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void btnEnableAction() {
    if (emailController.text.isNotEmpty ||
        (passwordController.text.isNotEmpty &&
            passwordController.text == confirmPasswordController.text)) {
      _isbtnEnable = true;
      notifyListeners();
    } else {
      _isbtnEnable = false;
      notifyListeners();
    }
  }

  void updatePassword(BuildContext context, password, email) async {
    _isLoading = true;
    notifyListeners();
    print(password);
    http.Response response = await ApiRoot.request(
      {
        "email": email,
        "password": password,
      },
      url: 'user/password/reset',
    );

    final body = json.decode(response.body)['result'];
    print(response.body);
    if (body['status_code'] == 200) {
      Fluttertoast.showToast(
        msg: "Password reset successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Future.delayed(
        const Duration(seconds: 0),
        () => Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: body['error'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    _isLoading = false;
    notifyListeners();
  }

  void checkEmail(
    BuildContext context, {
    required String email,
  }) async {
    _isLoading = true;
    notifyListeners();
    http.Response response = await ApiRoot.request(
      {
        "email": email,
      },
      url: 'user/check_email',
    );

    final body = json.decode(response.body)['result'];
    print(response.body);
    if (body['status_code'] == 200) {
      Navigator.of(context).pushNamed(
        "/verifyemail",
        arguments: {
          "email": email,
          "password": '',
          'purpose': 'password_reset'
        },
      );
    } else {
      Fluttertoast.showToast(
        msg: body['error'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}

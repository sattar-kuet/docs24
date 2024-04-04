import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailbox/page/Auth/Login/Provider/loginProvider.dart';
import 'package:mailbox/utility/APIRoot.dart';
import 'package:provider/provider.dart';

class EmailVerifyProvider extends ChangeNotifier {
  String _otp = '';
  String get otp => _otp;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void initOtpAction(String value) {
    if (value.length == 6) {
      _otp = value;
      notifyListeners();
    } else {
      _otp = '';
      notifyListeners();
    }
  }

  void otpVerifyAction(
    BuildContext context, {
    required String email,
    required String otp,
    required String password,
    required String purpose,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      dynamic data = {
        "email": email,
        "email_verification_code": otp,
      };
      print(data);
      final response = await ApiRoot.request(data, url: 'email/verify');

      dynamic responseBody = json.decode(response.body)['result'];

      if (responseBody['status'] == true) {
        Fluttertoast.showToast(
          msg: responseBody['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if (purpose == 'registration') {
          // ignore: use_build_context_synchronously
          Provider.of<LoginProvider>(context, listen: false).loginAction(
            context,
            email: email,
            password: password,
          );
        } else if (purpose == 'password_reset') {
          // ignore: use_build_context_synchronously
          
          Navigator.of(context).pushNamed("/newPassword", arguments: {
            'email': email,
          });
        }
      } else {
        Fluttertoast.showToast(
          msg: responseBody['error'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      // Handle the FlutterError here, e.g., display an error message.
      print("Error occurred: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:docs24/utility/APIRoot.dart';

class RegisterProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController position = TextEditingController();
  String _accountType = ''; // Initialize with an empty string

  String get accountType => _accountType;

  String _emailStateText = '';

  String get emailStateText => _emailStateText;

  bool _emailState = false;
  bool get emailState => _emailState;

  void updateEmailState(String message, bool state) {
    _emailStateText = message;
    _emailState = state;
    notifyListeners();
  }

  void updateAccountType(String newAccountType) {
    _accountType = newAccountType;
    notifyListeners();
  }

  List<String> _positionList = [];
  List<String> get positionList => _positionList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isbtnEnable = false;
  bool get isbtnEnabl => _isbtnEnable;

  String countryCode = '+880';
  String ISOcountryCode = 'BD';

  void getPositionListAction() async {
    http.Response response =
        await ApiRoot.request({}, url: 'position/list', isEmpty: true);
    if (response.statusCode == 200) {
      _positionList = (json.decode(response.body)['result']['data'] as List)
          .map((e) => e.toString())
          .toList();
      notifyListeners();
    }
  }

  void btnEnableAction() {
    if (phone.text.isNotEmpty &&
        name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        emailState &&
        password.text.isNotEmpty) {
      _isbtnEnable = true;
      notifyListeners();
    } else {
      _isbtnEnable = false;
      notifyListeners();
    }
  }

  void registerAction(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    http.Response response = await ApiRoot.request(
      {
        "name": name.value.text,
        "email": email.value.text,
        "phone": phone.value.text,
        "country_code": countryCode,
        "iso_country_code": ISOcountryCode,
        "password": password.value.text,
        "position": position.value.text,
        "account_type": accountType
      },
      url: 'custom/registration',
    );

    final body = json.decode(response.body)['result'];

    if (body['status_code'] == 200) {
      Navigator.of(context).pushNamed(
        "/verifyemail",
        arguments: {
          "email": email.value.text,
          "password": password.value.text,
          "purpose": 'registration',
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

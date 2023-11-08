// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:docs24/utility/APIRoot.dart';
import 'package:docs24/utility/systemInfo.dart';

import '../Model/userModel.dart';

class ProfileProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController position = TextEditingController();

  int id = 0;
  List<String> _positionList = [];
  List<String> get positionList => _positionList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _initialPosition = '';
  String get initialPosition => _initialPosition;

  bool _isbtnEnable = false;
  bool get isbtnEnabl => _isbtnEnable;

  String countryCode = '';
  String ISOcountryCode = '';

  String _emailStateText = '';

  String get emailStateText => _emailStateText;

  bool _emailState = false;
  bool get emailState => _emailState;

  void updateEmailState(String message, bool state) {
    _emailStateText = message;
    _emailState = state;
    notifyListeners();
  }

  void initialization() async {
    http.Response positionResponse =
        await ApiRoot.request({}, url: 'position/list', isEmpty: true);
    if (positionResponse.statusCode == 200) {
      _positionList =
          (json.decode(positionResponse.body)['result']['data'] as List)
              .map((e) => e.toString())
              .toList();
      notifyListeners();
    }
    int? uid = SystemInfo.getUid;
    http.Response userResponse =
        await ApiRoot.request({}, url: 'user/$uid', isEmpty: true);
    print(userResponse.body);
    if (userResponse.statusCode == 200) {
      UserModel user =
          UserModel.fromJson(json.decode(userResponse.body)['result']['user']);
      id = user.id!;
      name = TextEditingController(text: user.name);
      email = TextEditingController(text: user.email);
      phone = TextEditingController(text: user.phone);
      countryCode = user.countryCode!;
      ISOcountryCode = user.isoCountryCode!;
      position = TextEditingController(text: user.position);
      _initialPosition = user.position!;
      _isbtnEnable = true;
      _emailState = true;
      notifyListeners();
    }
  }

  void btnEnableAction() {
    if (phone.text.isNotEmpty &&
        name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        emailState) {
      _isbtnEnable = true;
      notifyListeners();
    } else {
      _isbtnEnable = false;
      notifyListeners();
    }
  }

  void profileAction(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    dynamic data = {
      "uid": id,
      "name": name.value.text,
      "email": email.value.text,
      "phone": phone.value.text,
      "country_code": countryCode,
      "iso_country_code": ISOcountryCode,
      "position": position.value.text,
    };

    print(data);

    http.Response response = await ApiRoot.request(
      data,
      url: 'user/edit',
    );

    final body = json.decode(response.body)['result'];
    print(body);

    if (body['status_code'] == 200) {
      Navigator.of(context).pushNamed(
        "/profile",
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

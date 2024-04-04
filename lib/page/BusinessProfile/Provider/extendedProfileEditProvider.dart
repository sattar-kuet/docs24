import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mailbox/utility/APIRoot.dart';
import 'package:mailbox/utility/systemInfo.dart';

import '../Model/extendedProfileModel.dart';

class ExtendedProfileEditProvider extends ChangeNotifier {
  TextEditingController address = TextEditingController();

  String _countryName = "";
  String get countryName => _countryName;

  String _stateName = "";
  String get stateName => _stateName;

  bool _startTyping = false;
  bool get startTyping => _startTyping;

  List<String> _countryList = [];
  List<String> get countryList => _countryList;
  List<String> _stateList = [];
  List<String> get stateList => _stateList;

  dynamic _image = "";
  dynamic get image => _image;
  int id = 0;

  bool _btnEnable = false;
  bool get btnEnable => _btnEnable;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void countryUpdate(String country) {
    _countryName = country;
    notifyListeners();
  }

  void stateUpdate(String state) {
    _stateName = state;
    notifyListeners();
  }

  void updateStartTyping(bool state) {
    _startTyping = state;
    notifyListeners();
  }

  void btnEnableaction() {
    if (address.value.text.isNotEmpty &&
        _countryName.isNotEmpty &&
        _stateName.isNotEmpty) {
      _btnEnable = true;
      notifyListeners();
    } else {
      _btnEnable = false;
      notifyListeners();
    }
  }

  void initialization() async {
    http.Response countryResponse =
        await ApiRoot.request({}, url: 'location/country', isEmpty: true);
    if (countryResponse.statusCode == 200) {
      _countryList =
          (json.decode(countryResponse.body)['result']['data'] as List)
              .map((e) => e.toString())
              .toList();
      notifyListeners();
    }
    stateListUpdate(_countryName);
    int? uid = SystemInfo.getUid;
    final response = await ApiRoot.request(
      {},
      url: "company/$uid",
      isEmpty: true,
    );
    print("response.body ##############");
    print(response.body);
    final body = json.decode(response.body)['result'];
    if (body['status_code'] == 200) {
      ExtendedProfileModel extendedProfile = ExtendedProfileModel.fromJson(
          json.decode(response.body)['result']['data']);
      id = extendedProfile.id!;
      address = TextEditingController(text: extendedProfile.address);
      _image = extendedProfile.logo!;
      _btnEnable = true;
      _countryName = extendedProfile.country!;
      _stateName = extendedProfile.city!;
      notifyListeners();
    }
  }

  void stateListUpdate(String countryName) async {
    http.Response stateResponse = await ApiRoot.request({},
        url: 'location/state/$countryName', isEmpty: true);
    // print("stateResponse.body ???????????????????");
    // print(stateResponse.body);
    if (stateResponse.statusCode == 200) {
      _stateList = (json.decode(stateResponse.body)['result']['data'] as List)
          .map((e) => e.toString())
          .toList();
      notifyListeners();
    }
  }

  void profileImage(String value) {
    _image = value;
    notifyListeners();
  }

  void personalProfileAction(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    dynamic data = {
      'logo': _image,
      "country_name": countryName,
      "city": stateName,
      "business_address": address.value.text,
      "uid": SystemInfo.getUid
    };
    //print(data);
    http.Response response =
        await ApiRoot.request(data, url: 'extended_profile/edit');
    final body = json.decode(response.body)['result'];
    log(response.body);
    if (body['status_code'] == 200) {
      Fluttertoast.showToast(
          msg: "Extended Profile create successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/welcome', (route) => false);
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

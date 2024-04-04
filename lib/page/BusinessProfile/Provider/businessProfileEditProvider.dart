import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mailbox/page/BusinessProfile/Model/businessProfileModel.dart';
import 'package:mailbox/page/BusinessProfile/Model/categoryModel.dart';
import 'package:mailbox/utility/APIRoot.dart';
import 'package:mailbox/utility/systemInfo.dart';

class BusinessProfileEditProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController abn = TextEditingController();

  String _countryName = "";
  String get countryName => _countryName;

  bool _startTyping = false;
  bool get startTyping => _startTyping;

  String _stateName = "";
  String get stateName => _stateName;

  List<String> _countryList = [];
  List<String> get countryList => _countryList;
  List<String> _stateList = [];
  List<String> get stateList => _stateList;

  dynamic _image = "";
  dynamic get image => _image;
  int id = 0;

  List<CategoryModel> _cateList = [];
  List<CategoryModel> get categoryList => _cateList;
  List<int> _selectcateDataList = [];
  List<int> get selectcateDataList => _selectcateDataList;

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
    // print("response.body ##############");
    // print(response.body);
    final body = json.decode(response.body)['result'];
    if (body['status_code'] == 200) {
      BusinessProfileModel businessProfile = BusinessProfileModel.fromJson(
          json.decode(response.body)['result']['data']);
      id = businessProfile.id!;
      name = TextEditingController(text: businessProfile.name);
      website = TextEditingController(text: businessProfile.url);
      abn = TextEditingController(text: businessProfile.abn);
      address = TextEditingController(text: businessProfile.address);
      _selectcateDataList = businessProfile.categoryIds!;
      _image = businessProfile.logo!;
      _btnEnable = true;
      _countryName = businessProfile.country!;
      _stateName = businessProfile.city!;
      _startTyping = false;
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

  void categoryInitAction(List<int> value) {
    _selectcateDataList = value;
    notifyListeners();
  }

  void profileImage(String value) {
    _image = value;
    notifyListeners();
  }

  void btnEnableaction() {
    if (name.value.text.isNotEmpty &&
        address.value.text.isNotEmpty &&
        abn.value.text.isNotEmpty &&
        _selectcateDataList.isNotEmpty) {
      _btnEnable = true;
      notifyListeners();
    } else {
      _btnEnable = false;
      notifyListeners();
    }
  }

  void businessProfileAction(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    http.Response response = await ApiRoot.request({
      "id": id,
      "categories": _selectcateDataList,
      'logo': _image,
      "abn": abn.value.text,
      "business_name": name.value.text,
      "country_name": countryName,
      "city": stateName,
      "business_address": address.value.text,
      "phone": phone.value.text,
      "country_code": "",
      "mobile": mobile.value.text,
      "website": website.value.text,
      "email": email.value.text,
      "uid": SystemInfo.getUid
    }, url: 'company/edit');
    final body = json.decode(response.body)['result'];
    log(response.body);
    if (body['status_code'] == 200) {
      Fluttertoast.showToast(
          msg: "Business Profile create successful",
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

  void categoeryListAction() async {
    _isLoading = true;
    final response = await ApiRoot.request(
      {},
      url: "company/categories",
      isEmpty: true,
    );
    if (response.statusCode == 200) {
      _cateList = (json.decode(response.body)['result']['data'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    }
    _isLoading = false;
    notifyListeners();
  }
}

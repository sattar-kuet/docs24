import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:docs24/page/Contact/Model/contactModel.dart';
import 'package:docs24/utility/APIRoot.dart';
import 'package:docs24/utility/systemInfo.dart';

class ContactProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phoneTemp = TextEditingController();
  TextEditingController companyName = TextEditingController();

  String countryCode = '+880';
  String countryISOCode = 'BD';

  int id = 0;

  bool _btnEnable = false;
  bool get btnEnable => _btnEnable;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _emailStateText = '';

  String get emailStateText => _emailStateText;

  bool _emailState = false;
  bool get emailState => _emailState;

  void updateEmailState(String message, bool state) {
    _emailStateText = message;
    _emailState = state;
    notifyListeners();
  }

  void btnEnableaction() {
    if (name.value.text.isNotEmpty &&
        email.value.text.isNotEmpty &&
        emailState &&
        phone.value.text.isNotEmpty &&
        companyName.value.text.isNotEmpty) {
      _btnEnable = true;
      notifyListeners();
    } else {
      _btnEnable = false;
      notifyListeners();
    }
  }

  void existingContactInitialize(ContactModel contact) async {
    if (contact != ContactModel()) {
      id = contact.id as int;
      name = TextEditingController(text: contact.name);
      email = TextEditingController(text: contact.email);
      phone = TextEditingController(text: contact.phone);
      countryCode = contact.countryCode as String;
      countryISOCode = contact.countryISOCode as String;
      companyName = TextEditingController(text: contact.companyName);
      _btnEnable = true;
      _emailState = true;
      notifyListeners();
    }
  }

  void contactCreateORupdate(BuildContext context) async {
    if (id == 0) {
      contactCreate(context);
    } else {
      contactUpdate(context);
    }
  }

  void contactCreate(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    dynamic data = {
      "name": name.value.text,
      "email": email.value.text,
      "phone": phone.value.text,
      "country_code": countryCode,
      "country_iso_code": countryISOCode,
      "company_name": companyName.value.text,
      "uid": SystemInfo.getUid
    };
    print(data);
    http.Response response = await ApiRoot.request(data, url: 'contact/create');
    final body = json.decode(response.body)['result'];
    log(response.body);
    if (body['status_code'] == 200) {
      Fluttertoast.showToast(
          msg: "New contact create successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/contactList', (route) => false);
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

  void contactUpdate(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    dynamic data = {
      "id": id,
      "name": name.value.text,
      "email": email.value.text,
      "phone": phone.value.text,
      "country_code": countryCode,
      "country_iso_code": countryISOCode,
      "company_name": companyName.value.text,
      "uid": SystemInfo.getUid
    };
    http.Response response = await ApiRoot.request(data, url: 'contact/edit');
    final body = json.decode(response.body)['result'];
    log(response.body);
    if (body['status_code'] == 200) {
      Fluttertoast.showToast(
          msg: "Contact update successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/contactList', (route) => false);
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

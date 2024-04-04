import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mailbox/page/Employee/Model/employeeModel.dart';
import 'package:mailbox/utility/APIRoot.dart';
import 'package:mailbox/utility/systemInfo.dart';

class EmployeeProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController position = TextEditingController();

  List<String> _positionList = [];
  List<String> get positionList => _positionList;

  int id = 0;
  String countryCode = '+880';
  String countryISOCode = 'BD';
  bool _btnEnable = false;
  bool get btnEnable => _btnEnable;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void initializePositionListAction() async {
    http.Response response =
        await ApiRoot.request({}, url: 'position/list', isEmpty: true);
    if (response.statusCode == 200) {
      _positionList = (json.decode(response.body)['result']['data'] as List)
          .map((e) => e.toString())
          .toList();
      notifyListeners();
    }
  }

  void btnEnableaction() {
    if (name.value.text.isNotEmpty &&
        email.value.text.isNotEmpty &&
        phone.value.text.isNotEmpty &&
        position.value.text.isNotEmpty) {
      _btnEnable = true;
      notifyListeners();
    } else {
      _btnEnable = false;
      notifyListeners();
    }
  }

  void existingEmployeeInitialize(EmployeeModel employee) async {
    if (employee != EmployeeModel()) {
      id = employee.id as int;
      name = TextEditingController(text: employee.name);
      email = TextEditingController(text: employee.email);
      phone = TextEditingController(text: employee.phone);
      countryCode = employee.countryCode as String;
      countryISOCode = employee.countryISOCode as String;
      position = TextEditingController(text: employee.position);
      _btnEnable = true;
      notifyListeners();
    }
  }

  void employeeCreateORupdate(BuildContext context) async {
    if (id == 0) {
      employeeCreate(context);
    } else {
      employeeUpdate(context);
    }
  }

  void employeeCreate(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    dynamic data = {
      "name": name.value.text,
      "email": email.value.text,
      "phone": phone.value.text,
      "country_code": countryCode,
      "country_iso_code": countryISOCode,
      "position": position.value.text,
      "uid": SystemInfo.getUid
    };
    //print(data);
    http.Response response =
        await ApiRoot.request(data, url: 'employee/create');
    final body = json.decode(response.body)['result'];
    log(response.body);
    if (body['status_code'] == 200) {
      Fluttertoast.showToast(
          msg: "New employee create successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/employeeList', (route) => false);
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

  void employeeUpdate(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    http.Response response = await ApiRoot.request({
      "id": id,
      "name": name.value.text,
      "email": email.value.text,
      "phone": phone.value.text,
      "country_code": countryCode,
      "country_iso_code": countryISOCode,
      "position": position.value.text,
      "uid": SystemInfo.getUid
    }, url: 'employee/edit');
    final body = json.decode(response.body)['result'];
    log(response.body);
    if (body['status_code'] == 200) {
      Fluttertoast.showToast(
          msg: "Employee update successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/employeeList', (route) => false);
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

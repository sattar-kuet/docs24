import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mailbox/page/Employee/Model/employeeModel.dart';
import 'package:mailbox/utility/APIRoot.dart';
import 'package:mailbox/utility/systemInfo.dart';

class EmployeeListProvider extends ChangeNotifier {
  List<EmployeeModel> _employeeList = [];
  List<EmployeeModel> get employeeList => _employeeList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void getEmployeeList() async {
    _isLoading = true;
    final response = await ApiRoot.request(
      {
        "uid": SystemInfo.getUid,
      },
      url: "employee/list",
    );
    print(response.body);
    if (response.statusCode == 200) {
      _employeeList = (json.decode(response.body)['result']['data'] as List)
          .map((e) => EmployeeModel.fromJson(e))
          .toList();
    }
    _isLoading = false;
    notifyListeners();
  }
}

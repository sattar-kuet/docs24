// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailbox/page/SendMail/Model/contactListModel.dart';
import 'package:mailbox/page/SendMail/Model/emailListDetailsModel.dart';
import 'package:mailbox/page/SendMail/Model/emailtamplateModel.dart';
import 'package:mailbox/utility/APIRoot.dart';
import 'package:mailbox/utility/systemInfo.dart';

class SendMailProvider extends ChangeNotifier {
  List<EmailTamplateModel> _tamplateList = [];
  List<EmailTamplateModel> get tamplateList => _tamplateList;

  // List<EmailDataModel> _emailDataList = [];
  // List<EmailDataModel> get emailDataList => _emailDataList;

  List<ContactListModel> _contactList = [];
  List<ContactListModel> get contactList => _contactList;

  List<MailListDetailsModel> _selectedContactList = [];
  List<MailListDetailsModel> get selectedContactList => _selectedContactList;

  TextEditingController projectName = TextEditingController();
  TextEditingController projectAddress = TextEditingController();
  TextEditingController clientName = TextEditingController();

  // ignore: unrelated_type_equality_checks
  String? _selectedDate = '';
  String? get selectedDate => _selectedDate;

  String _selectedMailTemplateCode = "";
  String get selectedMailTemplateCode => _selectedMailTemplateCode;

  dynamic _signature = false;
  dynamic get signature => _signature;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isbtnEnabl = false;
  bool get isbtnEnabl => _isbtnEnabl;

  void initialization() {
    _selectedContactList = [];
  }

  void setSelectedDate(String selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
    btnEnableAction();
  }

  void onSelectEmailTamplate(String value) {
    _selectedMailTemplateCode = value;
    notifyListeners();
    btnEnableAction();
  }

  void tamplateListAction() async {
    _isLoading = true;

    notifyListeners();
    final response = await ApiRoot.request(
      {"uid": SystemInfo.getUid},
      url: "email/templates",
    );
    print("SystemInfo.getUid >>>>> ?????");
    print(SystemInfo.getUid);
    if (response.statusCode == 200) {
      _tamplateList = (json.decode(response.body)['result']['data'] as List)
          .map((e) => EmailTamplateModel.fromJson(e))
          .toList();
      btnEnableAction();
    }
    _isLoading = false;
    notifyListeners();
  }

  void signatureAction() async {
    _isLoading = true;

    notifyListeners();
    final response = await ApiRoot.request(
      {"uid": SystemInfo.getUid},
      url: "get_signature",
    );

    if (response.statusCode == 200) {
      _signature = json.decode(response.body)['result']['signature'];
      btnEnableAction();
    }
    _isLoading = false;
    notifyListeners();
  }

  void contactListaction() async {
    _isLoading = true;
    notifyListeners();
    final response = await ApiRoot.request(
      {"uid": SystemInfo.getUid},
      url: "contact/list",
    );

    if (response.statusCode == 200) {
      _contactList = (json.decode(response.body)['result']['data'] as List)
          .map((e) => ContactListModel.fromJson(e))
          .toList();
    }
    _isLoading = false;
    notifyListeners();
  }

  void mailSelectListDetails(List<int> value) async {
    _isLoading = true;
    notifyListeners();
    final response =
        await ApiRoot.request({'id': value}, url: 'contact/detail');

    if (response.statusCode == 200) {
      _selectedContactList =
          (json.decode(response.body)['result']['data'] as List)
              .map((e) => MailListDetailsModel.fromJson(e))
              .toList();
      btnEnableAction();
    }
    _isLoading = false;
    notifyListeners();
  }

  void clearAction() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });

    btnEnableAction();
  }

  void sendMailAction(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    print("selectedDate ?????????????????????????");
    print(selectedDate);
    final response = await ApiRoot.request({
      "contact_ids": _selectedContactList.map((e) => e.id).toList(),
      'sender_date': selectedDate,
      "project_name": projectName.value.text,
      "client_name": clientName.value.text,
      "project_address": projectAddress.value.text,
      "template_code": selectedMailTemplateCode,
      "uid": SystemInfo.getUid
    }, url: 'email/send');
    final body = json.decode(response.body)['result'];
    log(response.body);
    if (body['status_code'] == 200) {
      Fluttertoast.showToast(
          msg: body['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/emailLog', (route) => false);
    } else {
      Fluttertoast.showToast(
        msg: "Failed to send email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    _isLoading = false;
    _selectedMailTemplateCode = '';
    notifyListeners();
  }

  void btnEnableAction() {
    if (_selectedMailTemplateCode.isNotEmpty &&
        _selectedContactList.isNotEmpty) {
      _isbtnEnabl = true;
    } else {
      _isbtnEnabl = false;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }
}

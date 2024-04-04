import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mailbox/page/Contact/Model/contactModel.dart';
import 'package:mailbox/utility/APIRoot.dart';
import 'package:mailbox/utility/systemInfo.dart';

class ContactListProvider extends ChangeNotifier {
  List<ContactModel> _contactList = [];
  List<ContactModel> get contactList => _contactList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void getContactList() async {
    _isLoading = true;
    final response = await ApiRoot.request(
      {
        "uid": SystemInfo.getUid,
      },
      url: "contact/detail_list",
    );
    print(response.body);
    if (response.statusCode == 200) {
      _contactList = (json.decode(response.body)['result']['data'] as List)
          .map((e) => ContactModel.fromJson(e))
          .toList();
    }
    _isLoading = false;
    notifyListeners();
  }
}

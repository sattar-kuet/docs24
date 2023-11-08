import 'package:flutter/material.dart';
import '../../../utility/APIRoot.dart';
import '../../../utility/systemInfo.dart';

void logOut(BuildContext context) async {
  // Logout Function Then status 200 then Navigator

  final response = await ApiRoot.request(
    {"uid": SystemInfo.getUid},
    url: "logout",
  );

  if (response.statusCode == 200) {
    SystemInfo.removeUID();
    SystemInfo.removeDBName();
    SystemInfo.removeToken();
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/welcome',
      (route) => false,
    );
  } else {
    Navigator.of(context).pop();
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

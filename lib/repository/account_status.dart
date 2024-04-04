import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mailbox/utility/APIRoot.dart';
import 'package:mailbox/utility/systemInfo.dart';

class AccountStatus {
  static Future<dynamic> userStateCheckAction() async {
    http.Response response = await ApiRoot.request(
      {
        "uid": SystemInfo.getUid,
      },
      url: 'user/status',
    );
    // print(response.body);
    final responsBody = json.decode(response.body)['result'];
    return responsBody;
  }
}

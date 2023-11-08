import 'dart:convert';

import 'package:http/http.dart' as http;
import '../utility/APIRoot.dart';
import '../utility/systemInfo.dart';

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

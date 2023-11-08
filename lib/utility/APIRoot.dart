import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'systemInfo.dart';

class ApiRoot {
  static Future<http.Response> request(data,
      {required String url, bool isEmpty = false, bool rooturl = false}) async {
    final mainUrl =
        rooturl ? Uri.parse("$Root_URl/$url") : Uri.parse("$BASE_URL/$url");
    print(mainUrl);

    http.Response response = await http.post(mainUrl,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'Cookie': 'session_id=${SystemInfo.getToken}'
          // 'Cookie': 'session_id=1c6af413972030cdd829e99b79621330fb8178f7'
        },
        body: isEmpty ? json.encode({}) : json.encode({"params": data}));
    return response;
  }
}

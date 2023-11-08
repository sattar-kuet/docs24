import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:docs24/utility/APIRoot.dart';
import 'package:docs24/utility/systemInfo.dart';

class JobApplyProvider extends ChangeNotifier {
  String _docFile = "";
  String get docFile => _docFile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void docFileSetAction(String docFile) {
    _docFile = docFile;
    notifyListeners();
  }

  void docFileUploadaction(
      {required BuildContext context,
      required String docFile,
      required int jobId}) async {
    _isLoading = true;
    notifyListeners();
    final response = await ApiRoot.request(
      {
        "job_id": jobId,
        "uid": SystemInfo.getUid,
        "cv": base64.encode(await File(docFile).readAsBytes())
      },
      url: "job/apply",
    );
    log("Job apply response Status ${response.statusCode}");

    if (response.statusCode == 200) {
      final body = json.decode(response.body)['result'];
      if (body['status']) {
        Fluttertoast.showToast(
          msg: body['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: body['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) => false,
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}

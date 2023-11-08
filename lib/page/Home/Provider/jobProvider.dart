import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:docs24/utility/APIRoot.dart';
import 'package:docs24/utility/systemInfo.dart';

import '../Model/job.dart';

class JobProvider extends ChangeNotifier {
  List<JobModel> _jobList = [];
  List<JobModel> get jobList => _jobList;

  JobModel _job = JobModel();
  JobModel get job => _job;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void getJobList() async {
    _isLoading = true;
    final response = await ApiRoot.request(
      {
        "uid": SystemInfo.getUid,
      },
      url: "job/list",
    );
    print(response.body);
    if (response.statusCode == 200) {
      _jobList = (json.decode(response.body)['result']['jobs'] as List)
          .map((e) => JobModel.fromJson(e))
          .toList();
    }
    _isLoading = false;
    notifyListeners();
  }

  void getJobDetail(int jobId) async {
    _isLoading = true;
    final response = await ApiRoot.request(
      {
        "uid": SystemInfo.getUid,
      },
      url: "job/detail/${jobId}",
    );
    print(response.body);
    final body = json.decode(response.body)['result'];
    if (response.statusCode == 200) {
      _job = JobModel.fromJson(json.decode(response.body)['result']['data']);
    }

    _isLoading = false;
    notifyListeners();
  }

  void apply(int jobId) async {
    _isLoading = true;
    final response = await ApiRoot.request(
      {
        "job_id": jobId,
        "uid": SystemInfo.getUid,
        "cv": 'TODO: CV FILE WILL BE SENT AS BINARY DATA AS Like imageData of signatureAction(BuildContext context, String imageData)'
      },
      url: "job/apply",
    );
    print(response.body);
    final body = json.decode(response.body)['result'];
    if (response.statusCode == 200) {
      // TODO
    }

    _isLoading = false;
    notifyListeners();
  }
}

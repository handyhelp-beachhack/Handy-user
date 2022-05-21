import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/models/job_model.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/widgets/toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JobApi {
  static Future<List<JobModel>> getJobs() async {
    List<JobModel> jobs = [];
    String url = "https://app.geekstudios.tech/user/v1/job/get";
    Uri uri = Uri.parse(url);

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString("token");
    try {
      http.Response response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      ).timeout(const Duration(seconds: 3));
      print("result ${response.body}");

      if (jsonDecode(response.body)["response_code"] == 200) {
        var decoded = jsonDecode(response.body)["response"]["jobs"];
        jobs = List.from(decoded.map((e) => JobModel.fromMap(e)).toList());
      } else {
        showToast(
            context: Get.overlayContext!,
            color: Colors.orange,
            title: jsonDecode(response.body)["message"],
            description: "",
            icon: Icons.warning);
        // return;
      }
    } catch (e) {
      debugPrint("Error occured while registering $e");
      // return 501;
    }
    return jobs;
  }
}

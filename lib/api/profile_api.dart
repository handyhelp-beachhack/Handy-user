import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/controllers/user_model.dart';
import 'package:handy_beachhack/view/widgets/toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi {
  static Future<List<UserModel>> getJobs() async {
    String url = "https://app.geekstudios.tech/user/v1/profile/get";
    Uri uri = Uri.parse(url);
    List<UserModel> users = [];
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
        var decoded = jsonDecode(response.body)["response"]["user"];
        users.add(UserModel.fromMap(decoded));
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
    return users;
  }
}

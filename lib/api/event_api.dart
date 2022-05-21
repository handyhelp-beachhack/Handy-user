import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/models/event_model.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/authentification/otp_page.dart';
import 'package:handy_beachhack/view/screens/home/home_page.dart';
import 'package:handy_beachhack/view/widgets/toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:handy_beachhack/api/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventApi {
  static void createEvent({
    required String eventName,
    required String description,
    required String mobile,
    required DateTime eventDate,
    required double lat,
    required double lon,
  }) async {
    String url = "$baseUrl/user/v1/event/add";

    final uri = Uri.parse(url);
    Map<String, dynamic> body = {
      "name": eventName,
      "event_date": eventDate.toString(),
      "description": description,
      "contact_number": mobile,
      "lat": lat,
      "lon": lon
    };
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString("token");
    try {
      http.Response response = await http
          .post(
            uri,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 3));

      debugPrint("------------status code------------");
      debugPrint("${response.statusCode}");
      print(response.body);
      debugPrint("-----------------------------------");

      if (jsonDecode(response.body)["response_code"] == 200) {
        showToast(
            color: primaryPurple,
            context: Get.overlayContext!,
            title: jsonDecode(response.body)["message"],
            description: "",
            icon: Icons.check);
        Get.to(const HomePage());
      } else {
        showToast(
            context: Get.overlayContext!,
            color: Colors.orange,
            title: jsonDecode(response.body)["message"],
            description: "",
            icon: Icons.warning);
      }
    } catch (e) {
      debugPrint("Error occured while registering $e");
    }
  }

  static Future<List<EventModel>> getEvents() async {
    List<EventModel> events = [];
    String url = "https://app.geekstudios.tech/user/v1/event/get/600";
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
        var decoded = jsonDecode(response.body)["response"]["event"];
        events = List.from(decoded.map((e) => EventModel.fromMap(e)).toList());
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
      debugPrint("Error occured while fetching eveent $e");
      // return 501;
    }
    return events;
  }
}

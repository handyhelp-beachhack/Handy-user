import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/authentification/extra-datails/signup_page.dart';
import 'package:handy_beachhack/view/screens/authentification/otp_page.dart';
import 'package:handy_beachhack/view/screens/home/home_page.dart';
import 'package:handy_beachhack/view/widgets/toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = "https://app.geekstudios.tech";

class RegisterApi {
  static Future<int> emailCheck(
      {required String mobile, required String countryCode}) async {
    String url = "$baseUrl/auth/v1/login";
    print("url $url");
    final uri = Uri.parse(url);
    print("phone $mobile");
    // print("country $countryCode");
    Map<String, dynamic> body = {"phone": mobile, "account_type": "user"};
    try {
      http.Response response = await http
          .post(
            uri,
            headers: {"Content-Type": "application/json"},
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 8));

      debugPrint("------------status code------------");
      debugPrint("${response.statusCode}");
      print(response.body);
      debugPrint("st ${jsonDecode(response.body)["status_code"]}");
      debugPrint("message ${jsonDecode(response.body)["message"]}");
      debugPrint("response ${jsonDecode(response.body)}");

      debugPrint("-----------------------------------");
      if (jsonDecode(response.body)["response_code"] == 200) {
        showToast(
            color: primaryPurple,
            context: Get.overlayContext!,
            title: jsonDecode(response.body)["message"],
            description: "",
            icon: Icons.check);
        Get.to(OtpPage(
          mobile: mobile,
          countryCode: countryCode,
          passedOtp: jsonDecode(response.body)["response"]["otp"],
        ));
        return 200;
      } else {
        showToast(
            context: Get.overlayContext!,
            color: Colors.orange,
            title: jsonDecode(response.body)["message"],
            description: "",
            icon: Icons.warning);
        return 400;
      }
    } catch (e) {
      debugPrint("Error occured while registering $e");
      return 501;
    }
  }

  static Future<int> verificationApi(
      {required String mobile,
      required String countryCode,
      required String otp}) async {
    String url = "$baseUrl/auth/v1/validate/otp/";
    print("url $url");
    final uri = Uri.parse(url);
    print("phone $mobile");
    print("country $countryCode");
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("---------------------fcm-------------------");
    print("fcm $fcmToken ");
    print("---------------------fcm-------------------");
    Map<String, dynamic> body = {
      "phone": mobile,
      "otp": otp,
      "device": {
        "fcm": fcmToken,
      }
    };
    try {
      http.Response response = await http
          .post(
            uri,
            headers: {"Content-Type": "application/json"},
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 8));

      debugPrint("------------status code------------");
      debugPrint("${response.statusCode}");
      debugPrint("st ${jsonDecode(response.body)["status_code"]}");
      debugPrint("message ${jsonDecode(response.body)["message"]}");
      debugPrint("response ${jsonDecode(response.body)}");

      debugPrint("-----------------------------------");
      if (jsonDecode(response.body)["response_code"] == 200) {
        if (jsonDecode(response.body)["response_code"] == 200) {
          showToast(
              color: primaryPurple,
              context: Get.overlayContext!,
              title: jsonDecode(response.body)["message"],
              description: "",
              icon: Icons.check);

          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString(
              "token", jsonDecode(response.body)["response"]["accessToken"]);
          pref.setString(
              "mobile", jsonDecode(response.body)["response"]["user"]["phone"]);

          if (jsonDecode(response.body)["response"]["user"]
                  ["profile_completion"] ==
              0) {
            Get.to(SignupPage());
          } else {
            Get.to(HomePage());
          }
          return 200;
        } else {
          showToast(
              context: Get.overlayContext!,
              color: Colors.orange,
              title: jsonDecode(response.body)["message"],
              description: "",
              icon: Icons.warning);
          return 400;
        }
      } else {
        showToast(
            context: Get.overlayContext!,
            color: Colors.orange,
            title: jsonDecode(response.body)["message"],
            description: "",
            icon: Icons.warning);

        return 400;
      }
    } catch (e) {
      debugPrint("Error occured while registering $e");
      return 501;
    }
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

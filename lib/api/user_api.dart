import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/widgets/toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//{"response_code":200,"message":"Profile fetched successfully.","response":{"users":[{"_id":"6274b707df4512cc10c5ebe0","name":"joyal","profile_images":[],"username":"joyal"},{"_id":"6274b642df4512cc10c5ebd2","name":"Pranav V","profile_images":[],"username":"pranav"}]}}

class UserSimplify {
  final String id;
  final String name;
  final List profiles;
  final String username;

  UserSimplify(
      {required this.id,
      required this.name,
      required this.profiles,
      required this.username});

  factory UserSimplify.fromJson(Map<String, dynamic> json) => UserSimplify(
      id: json["_id"],
      name: json["name"],
      profiles: json["profile_images"],
      username: json["username"]);
}

class UserApi {
//   static Future<UserModel?> getDetailsUser(String id) async {
//     print("Caing");

//     String url = "http://app.geekstudios.tech/user/v1/profile/view/user";
//     final uri = Uri.parse(url);
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String? accessToken = pref.getString("token");
//     try {
//       http.Response response = await http.post(
//         uri,
//         body: jsonEncode({"id": id}),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $accessToken"
//         },
//       ).timeout(const Duration(seconds: 3));

//       if (jsonDecode(response.body)["response_code"] == 200) {
//         showToast(
//             color: primaryPurple,
//             context: Get.overlayContext!,
//             title: jsonDecode(response.body)["message"],
//             description: "",
//             icon: Icons.check);

//         return UserModel.fromMap(jsonDecode(response.body)["response"]["user"]);
//       } else {
//         showToast(
//             context: Get.overlayContext!,
//             color: Colors.orange,
//             title: jsonDecode(response.body)["message"],
//             description: "",
//             icon: Icons.warning);
//         // return;
//       }
//     } catch (e) {
//       debugPrint("Error occured while registering $e");
//       // return 501;
//     }
//   }

  static Future<List<UserSimplify>> getFriends(String id) async {
    List<UserSimplify> friends = [];

    String url = "http://app.geekstudios.tech/user/v1/request/get";
    final uri = Uri.parse(url);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString("token");
    try {
      http.Response response = await http.post(
        uri,
        body: jsonEncode({"id": id}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      ).timeout(const Duration(seconds: 3));

      if (jsonDecode(response.body)["response_code"] == 200) {
        showToast(
            color: primaryPurple,
            context: Get.overlayContext!,
            title: jsonDecode(response.body)["message"],
            description: "",
            icon: Icons.check);
        List<Map<String, dynamic>> decoded =
            jsonDecode(response.body)["response"]["users"];

        friends = decoded.map((e) => UserSimplify.fromJson(e)).toList();
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
    return friends;
  }

  static Future<void> sendFriendRequest(String id) async {
    String url = "http://app.geekstudios.tech/user/v1/request/sent";

    final uri = Uri.parse(url);

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString("token");

    try {
      http.Response response = await http.post(
        uri,
        body: jsonEncode({"id": id}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      ).timeout(const Duration(seconds: 3));

      if (jsonDecode(response.body)["response_code"] == 200) {
        showToast(
            color: primaryPurple,
            context: Get.overlayContext!,
            title: jsonDecode(response.body)["message"],
            description: "",
            icon: Icons.check);
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
  }

  // static Future<void> getUser(
  //     {required ProfileController profileController}) async {
  //   String url = "http://app.geekstudios.tech/user/v1/profile/get";
  //   print("url $url");
  //   final uri = Uri.parse(url);

  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? accessToken = pref.getString("token");

  //   try {
  //     http.Response response = await http.get(
  //       uri,
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $accessToken"
  //       },
  //     ).timeout(const Duration(seconds: 3));
  //     if (jsonDecode(response.body)["response_code"] == 200) {
  //       showToast(
  //           color: primaryPurple,
  //           context: Get.overlayContext!,
  //           title: jsonDecode(response.body)["message"],
  //           description: "",
  //           icon: Icons.check);
  //       profileController.userProfile =
  //           UserModel.fromMap(jsonDecode(response.body)["response"]["user"]);
  //       profileController.update();
  //     } else {
  //       showToast(
  //           context: Get.overlayContext!,
  //           color: Colors.orange,
  //           title: jsonDecode(response.body)["message"],
  //           description: "",
  //           icon: Icons.warning);
  //       // return;
  //     }
  //   } catch (e) {
  //     debugPrint("Error occured while registering $e");
  //     // return 501;
  //   }
  // }

  static Future<List<UserSimplify>> getNearbyUsers(String km) async {
    String url =
        "http://app.geekstudios.tech/user/v1/profile/get/nearby-users/$km";
    final uri = Uri.parse(url);

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString("token");
    print(accessToken);
    List<UserSimplify> users = [];
    try {
      http.Response response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      ).timeout(const Duration(seconds: 3));
      print("------------------------");
      print(response.body);
      if (jsonDecode(response.body)["response_code"] == 200) {
        showToast(
            color: primaryPurple,
            context: Get.overlayContext!,
            title: jsonDecode(response.body)["message"],
            description: "",
            icon: Icons.check);

        final List a = jsonDecode(response.body)["response"]["users"];
        print(a);
        users = a.map((e) => UserSimplify.fromJson(e)).toList();
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
    }
    return users;
  }
}

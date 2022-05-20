import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/eventt-creation/event_creation.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontWeight: FontWeight.normal, color: Colors.white, fontSize: 16);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 250,
      color: primaryPurple,
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              // Get.to(ProfilePage(userProfile: profileController.userProfile!));
            },
            leading: Icon(
              Icons.search,
              color: white,
              size: 22,
            ),
            title: const Text(
              "find friends",
              style: textStyle,
            ),
          ),
          ListTile(
            onTap: () {
              // Get.to(const FindFriends());
            },
            leading: const Icon(
              Icons.people_alt_rounded,
              color: Colors.white,
            ),
            title: const Text(
              "list friends",
              style: textStyle,
            ),
          ),
          ListTile(
              onTap: () {
                Get.to(const EventCreation());
              },
              title: const Text(
                "create event",
                style: textStyle,
              ),
              leading: Icon(
                Icons.event,
                color: white,
                size: 22,
              )),
          ListTile(
              onTap: () {
                // Get.to(const ChatScreen());
              },
              title: const Text(
                "about us",
                style: textStyle,
              ),
              leading: Icon(
                Icons.people_alt_rounded,
                color: white,
                size: 22,
              )),
          Spacer(),
          ListTile(
              onTap: () {
                // Get.to(const ChatScreen());
              },
              title: const Text(
                "logout",
                style: textStyle,
              ),
              leading: Icon(
                Icons.logout,
                color: white,
                size: 22,
              )),
        ],
      ),
    );
  }
}

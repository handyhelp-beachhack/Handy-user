import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/controllers/event_cnotroller.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/profile/profile_page.dart';
import 'package:handy_beachhack/view/screens/speechtotext/speech_to_text.dart';
import 'package:handy_beachhack/view/screens/texttospeech/text_to_speech.dart';
import 'package:handy_beachhack/view/widgets/event_container.dart';
import 'package:handy_beachhack/view/screens/home/home_cards.dart';
import 'package:handy_beachhack/view/screens/learning/learning_page.dart';
import 'package:handy_beachhack/view/widgets/app_drawer.dart';
import 'package:handy_beachhack/view/widgets/appbar.dart';
import 'package:handy_beachhack/view/widgets/bottom_navigationbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  final eventController = Get.put(EventController());
  @override
  Widget build(BuildContext context) {
    eventController.getEvents();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        drawer: AppDrawer(),
        appBar: appBarCustom(
            prefixWidget: InkWell(
              onTap: () {
                _scaffoldState.currentState!.openDrawer();
              },
              child: const Icon(
                Icons.menu,
                color: white,
                size: 30,
              ),
            ),
            title: "home",
            suffixWidget: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(ProfilePage());
                  },
                  child: Icon(
                    Icons.account_circle,
                    color: white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                Icon(
                  Icons.notifications,
                  color: white,
                  size: 30,
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                Icon(
                  Icons.chat,
                  color: white,
                  size: 30,
                ),
              ],
            )),
        backgroundColor: white,
        bottomNavigationBar: BottomNavigationBarCustom(currentIndex: 0),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GetBuilder<EventController>(builder: (context) {
                  return eventController.eventList.isEmpty
                      ? SizedBox()
                      : EventContainer(
                          eventModel: eventController.eventList[0],
                        );
                }),
                const SizedBox(
                  height: defaultPadding,
                ),
                const Text(
                  " for deaf",
                  style: TextStyle(
                    color: grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeContainerOne(
                      ontap: () {
                        Get.to(LearningPage());
                      },
                      size: size,
                      assets: "learning",
                      title: "sign language\nlearning",
                    ),
                    HomeContainerOne(
                      ontap: () => {Get.to(TextToSpeech())},
                      assets: "speaking",
                      size: size,
                      title: "Live Speaking\n(text to speach)",
                    ),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                HomeContainerOne(
                  assets: "listening",
                  ontap: () => {Get.to(SpeechToText())},
                  size: size,
                  title: "Live Listening\n(speech to text)",
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  " for blind",
                  style: TextStyle(
                    color: grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeContainerOne(
                      size: size,
                      ontap: () => {},
                      assets: "search",
                      title: "Search It!\n(seach what\nyou want)",
                    ),
                    HomeContainerOne(
                      assets: "deetection",
                      size: size,
                      ontap: () => {},
                      title: "Live Speaking\n(text to speach)",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

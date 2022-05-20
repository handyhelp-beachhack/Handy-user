import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/events/event_view_page.dart';
import 'package:handy_beachhack/view/widgets/appbar.dart';
import 'package:handy_beachhack/view/widgets/bottom_navigationbar.dart';
import 'package:handy_beachhack/view/widgets/event_container.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBarCustom(currentIndex: 1),
        appBar: appBarCustom(title: "Events"),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              for (int i = 0; i < 20; i++)
                InkWell(
                  onTap: () {
                    Get.to(EventViewPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: EventContainer(),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

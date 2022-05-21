import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/controllers/event_cnotroller.dart';
import 'package:handy_beachhack/models/event_model.dart';
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
  EventController eventController = Get.find<EventController>();
  @override
  Widget build(BuildContext context) {
    eventController.getEvents();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBarCustom(currentIndex: 1),
        appBar: appBarCustom(title: "Events"),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: GetBuilder<EventController>(builder: (context) {
            return Column(
              children: [
                for (EventModel event in eventController.eventList)
                  InkWell(
                    onTap: () {
                      Get.to(EventViewPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: defaultPadding),
                      child: EventContainer(
                        eventModel: event,
                      ),
                    ),
                  )
              ],
            );
          }),
        ),
      ),
    );
  }
}

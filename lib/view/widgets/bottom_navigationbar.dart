import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/events/event_page.dart';
import 'package:handy_beachhack/view/screens/home/home_page.dart';
import 'package:handy_beachhack/view/screens/job/job_portal.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({Key? key, required this.currentIndex})
      : super(key: key);
  final int currentIndex;

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    List pages = [const HomePage(), const EventPage(), const JobPortal()];
    return BottomNavigationBar(
      backgroundColor: white,
      currentIndex: widget.currentIndex,
      onTap: (newIndex) {
        setState(() {
          if (newIndex != widget.currentIndex) {
            Get.to(pages[newIndex]);
          }
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: widget.currentIndex == 0 ? primaryPurple : Colors.grey,
              size: 28,
            ),
            label: "home"),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.event,
            color: widget.currentIndex == 1 ? primaryPurple : Colors.grey,
            size: 28,
          ),
          label: "event",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.business,
            color: widget.currentIndex == 2 ? primaryPurple : Colors.grey,
            size: 28,
          ),
          label: "job",
        ),
      ],
    );
  }
}

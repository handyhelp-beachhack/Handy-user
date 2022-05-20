import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handy_beachhack/view/widgets/appbar.dart';
import 'package:handy_beachhack/view/widgets/bottom_navigationbar.dart';

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
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handy_beachhack/view/widgets/appbar.dart';
import 'package:handy_beachhack/view/widgets/bottom_navigationbar.dart';

class JobPortal extends StatefulWidget {
  const JobPortal({Key? key}) : super(key: key);

  @override
  State<JobPortal> createState() => _JobPortalState();
}

class _JobPortalState extends State<JobPortal> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarCustom(title: "Jobs"),
        bottomNavigationBar: BottomNavigationBarCustom(currentIndex: 2),
      ),
    );
  }
}

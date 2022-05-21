import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/controllers/job_controller.dart';
import 'package:handy_beachhack/models/job_model.dart';
import 'package:handy_beachhack/view/widgets/appbar.dart';
import 'package:handy_beachhack/view/widgets/bottom_navigationbar.dart';

class JobPortal extends StatefulWidget {
  const JobPortal({Key? key}) : super(key: key);

  @override
  State<JobPortal> createState() => _JobPortalState();
}

class _JobPortalState extends State<JobPortal> {
  final jobController = Get.put(JobController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarCustom(title: "Jobs"),
        bottomNavigationBar: BottomNavigationBarCustom(currentIndex: 2),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}

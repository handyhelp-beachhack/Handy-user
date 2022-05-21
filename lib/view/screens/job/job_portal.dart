import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/controllers/job_controller.dart';
import 'package:handy_beachhack/models/job_model.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/job/job_conainer.dart';
import 'package:handy_beachhack/view/screens/job/job_view_page.dart';
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
    jobController.getJobs();
    return SafeArea(
      child: Scaffold(
        appBar: appBarCustom(title: "Jobs"),
        bottomNavigationBar: BottomNavigationBarCustom(currentIndex: 2),
        body: GetBuilder<JobController>(builder: (context) {
          return Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                for (JobModel job in jobController.jobList)
                  InkWell(
                    onTap: () {
                      Get.to(JobViewPage(job: job));
                    },
                    child: JobContainer(job: job),
                    // child: Container(
                    //     margin: EdgeInsets.all(8),
                    //     padding: EdgeInsets.symmetric(
                    //         vertical: 5, horizontal: defaultPadding),
                    //     width: double.maxFinite,
                    //     height: 55,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(5),
                    //         color: white,
                    //         boxShadow: [
                    //           BoxShadow(
                    //             blurRadius: 10,
                    //             color: primaryPurple.withOpacity(0.1),
                    //           )
                    //         ]),
                    //     child: Row(
                    //       children: [
                    //         Icon(
                    //           Icons.business,
                    //           color: primaryPurple,
                    //           size: 40,
                    //         ),
                    //         const SizedBox(
                    //           width: defaultPadding,
                    //         ),
                    //         Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               job.name,
                    //               style: TextStyle(
                    //                 color: primaryPurple,
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               height: 5,
                    //             ),
                    //             Text(
                    //               "${job.lpa} lpa",
                    //               style: TextStyle(
                    //                 color: primaryPurple,
                    //                 fontSize: 14,
                    //               ),
                    //             ),
                    //           ],
                    //         )
                    //       ],
                    //     )),
                  )
              ],
            ),
          );
        }),
      ),
    );
  }
}

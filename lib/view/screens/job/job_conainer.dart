import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handy_beachhack/database/event_backgrounds.dart';
import 'package:handy_beachhack/models/job_model.dart';
import 'package:handy_beachhack/view/constants/constants.dart';

class JobContainer extends StatelessWidget {
  const JobContainer({
    Key? key,
    required this.job,
  }) : super(key: key);
  final JobModel job;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  height: 130,
                  width: double.maxFinite,
                  decoration: BoxDecoration(),
                  child: Image(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                          "https://images8.alphacoders.com/104/thumb-1920-1048376.jpg"))),
            ),
            Positioned(
                bottom: 20,
                right: 10,
                child: Text(
                  job.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, color: white),
                )),
            Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  "${job.lpa}/year",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15, color: white),
                ))
          ],
        ),
        SizedBox(
          height: defaultPadding,
        )
      ],
    );
  }
}

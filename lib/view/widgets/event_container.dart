import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handy_beachhack/database/event_backgrounds.dart';
import 'package:handy_beachhack/view/constants/constants.dart';

class EventContainer extends StatelessWidget {
  const EventContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              height: 130,
              width: double.maxFinite,
              decoration: BoxDecoration(),
              child: Image(
                  fit: BoxFit.fill,
                  image:
                      CachedNetworkImageProvider(bglist[Random().nextInt(7)]))),
        ),
        Positioned(
            bottom: 20,
            right: 10,
            child: Text(
              "Koratty Infopark",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: white),
            )),
        Positioned(
            bottom: 4,
            right: 10,
            child: Text(
              "At 2:00 pm IST",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: white),
            ))
      ],
    );
  }
}

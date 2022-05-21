import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handy_beachhack/database/event_db.dart';
import 'package:handy_beachhack/models/event_model.dart';
import 'package:handy_beachhack/view/constants/constants.dart';

class EventViewPage extends StatefulWidget {
  const EventViewPage({Key? key}) : super(key: key);
  @override
  State<EventViewPage> createState() => _EventViewPageState();
}

class _EventViewPageState extends State<EventViewPage> {
  EventModel event = EventModel.fromMap(eventList[0]);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryPurple,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CachedNetworkImage(imageUrl: event.img),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        primaryPurple.withOpacity(0.0),
                        primaryPurple,
                      ])),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      "created by ${event.postedBy}",
                      style: TextStyle(
                        color: white.withOpacity(.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    event.description,
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${event.eventDate.day.toString()}-${event.eventDate.month.toString()}-${event.eventDate.year.toString()}",
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: white.withOpacity(0.3)),
                    padding: EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "contact number",
                            style: TextStyle(
                              color: white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            event.contactNumber,
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Container(
                    height: 80,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff32BEA6),
                    ),
                    child: Text(
                      "View on maps",
                      style: TextStyle(
                        color: white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

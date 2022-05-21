import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/api/event_api.dart';
import 'package:handy_beachhack/api/registration.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/eventt-creation/calender_overlay.dart';
import 'package:handy_beachhack/view/screens/eventt-creation/event_day_container.dart';
import 'package:handy_beachhack/view/screens/eventt-creation/time_controller.dart';
import 'package:handy_beachhack/view/widgets/buttons/rounded_rect_primary.dart';
import 'package:handy_beachhack/view/widgets/textfield_custome.dart';
import 'package:handy_beachhack/view/widgets/toast/toast.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../widgets/event_loc_widget.dart';

class EventCreation extends StatefulWidget {
  const EventCreation({Key? key}) : super(key: key);

  @override
  State<EventCreation> createState() => _EventCreationState();
}

class _EventCreationState extends State<EventCreation> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController minTextController =
      TextEditingController(text: "0");
  final TextEditingController hourTextController =
      TextEditingController(text: "0");
  bool loading = false;
  DateTime? eventDate;
  String eventDayString = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/svg/events-cuate.svg",
              height: 250,
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  TextFieldCustom(
                      hintText: "event name",
                      keyboardType: TextInputType.text,
                      textEditingController: nameController),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 5, horizontal: defaultPadding),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: primaryPurple.withOpacity(0.1),
                          )
                        ]),
                    child: Form(
                      child: TextFormField(
                        controller: descriptionController,
                        maxLength: 300,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "description",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFieldCustom(
                      hintText: "contact number",
                      keyboardType: TextInputType.number,
                      textEditingController: contactController),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              late OverlayEntry overlayEntry;
                              overlayEntry = OverlayEntry(
                                  builder: (context) => CalenderOverlay(
                                        onDateChanged: (time) {
                                          setState(() {
                                            eventDayString = time
                                                .toString()
                                                .substring(0, 10);
                                            overlayEntry.remove();
                                            eventDate = time;
                                          });
                                        },
                                        calenderOverlay: overlayEntry,
                                      ));
                              Overlay.of(context)?.insert(overlayEntry);
                            },
                            child: EventDayContainer(
                                birthdayDateString: eventDayString)),
                      ),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      TimeContainer(
                        hourTimeController: hourTextController,
                        minTimeController: minTextController,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  RoundedRectPrimaryButton(
                      loading: loading,
                      text: "continue",
                      onpressed: () {
                        setState(() {
                          loading = true;
                        });
                        if (nameController.text == "" ||
                            descriptionController.text == "" ||
                            contactController.text == "" ||
                            eventDayString == "") {
                          showToast(
                              context: context,
                              color: Colors.amber,
                              title: "all fields are required",
                              description: "",
                              icon: Icons.warning);
                        } else {
                          Get.to(GetMapLocation(
                            title: "Set Event Location",
                            onTap: (loc) {
                              DateTime due = DateTime(
                                eventDate!.year,
                                eventDate!.month,
                                eventDate!.day,
                                int.parse(hourTextController.text),
                                int.parse(minTextController.text),
                              );
                              EventApi.createEvent(
                                  eventName: nameController.text,
                                  description: descriptionController.text,
                                  mobile: contactController.text,
                                  eventDate: due,
                                  lat: loc.coordinates[1],
                                  lon: loc.coordinates[0]);
                            },
                          ));
                          // eventDate.hour = int.parse(hourTextController.text);

                        }

                        setState(() {
                          loading = false;
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

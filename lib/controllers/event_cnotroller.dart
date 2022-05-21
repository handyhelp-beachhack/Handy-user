import 'package:get/get.dart';
import 'package:handy_beachhack/api/event_api.dart';
import 'package:handy_beachhack/api/job_api.dart';
import 'package:handy_beachhack/database/event_db.dart';
import 'package:handy_beachhack/models/event_model.dart';
import 'package:handy_beachhack/models/job_model.dart';

class EventController extends GetxController {
  List<EventModel> eventList = [];
  getEvents() async {
    eventList = await EventApi.getEvents();
    print("total events ${eventList.length}");
    update();
  }
}

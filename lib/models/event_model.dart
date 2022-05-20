// To parse this JSON data, do
//
//     final eventModel = eventModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class EventModel {
  EventModel({
    required this.location,
    required this.id,
    required this.createdAt,
    required this.name,
    required this.eventDate,
    required this.description,
    required this.contactNumber,
    required this.img,
    required this.postedBy,
    required this.eventId,
    required this.updatedAt,
    required this.v,
  });

  Location location;
  String id;
  DateTime createdAt;
  String name;
  DateTime eventDate;
  String description;
  String contactNumber;
  String img;
  String postedBy;
  String eventId;
  DateTime updatedAt;
  int v;

  factory EventModel.fromMap(Map<String, dynamic> json) => EventModel(
        location: Location.fromMap(json["location"]),
        id: json["_id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        eventDate: DateTime.parse(json["event_date"]),
        description: json["description"],
        contactNumber: json["contact_number"],
        img: json["img"],
        postedBy: json["posted_by"],
        eventId: json["event_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "location": location.toMap(),
        "_id": id,
        "created_at": createdAt.toIso8601String(),
        "name": name,
        "event_date": eventDate.toIso8601String(),
        "description": description,
        "contact_number": contactNumber,
        "img": img,
        "posted_by": postedBy,
        "event_id": eventId,
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

import 'package:meta/meta.dart';
import 'dart:convert';

class LectureModel {
  LectureModel({
    required this.word,
    required this.link,
    required this.completed,
    this.time,
  });

  String word;
  String link;
  bool completed;
  DateTime? time;

  factory LectureModel.fromMap(Map<String, dynamic> json) => LectureModel(
        word: json["word"],
        link: json["link"],
        completed: json["completed"],
        time: json["time"] != null
            ? DateTime.parse(json["time"])
            : DateTime.now(),
      );

  Map<String, dynamic> toMap() => {
        "word": word,
        "link": link,
        "completed": completed,
        "time": time!.toIso8601String(),
      };
}

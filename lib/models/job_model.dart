import 'package:meta/meta.dart';
import 'dart:convert';

class JobModel {
  JobModel({
    required this.name,
    required this.endDate,
    required this.description,
    required this.jobType,
    required this.handicapType,
    required this.lpa,
    required this.contactNumber,
  });

  String name;
  DateTime endDate;
  String description;
  String jobType;
  String handicapType;
  int lpa;
  String contactNumber;

  factory JobModel.fromMap(Map<String, dynamic> json) => JobModel(
        name: json["name"],
        endDate: DateTime.parse(json["end_date"]),
        description: json["description"],
        jobType: json["job_type"],
        handicapType: json["handicap_type"],
        lpa: json["lpa"],
        contactNumber: json["contact_number"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "end_date": endDate.toIso8601String(),
        "description": description,
        "job_type": jobType,
        "handicap_type": handicapType,
        "lpa": lpa,
        "contact_number": contactNumber,
      };
}

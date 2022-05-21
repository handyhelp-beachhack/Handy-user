import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({
    required this.connectRequests,
    required this.phone,
    required this.id,
    required this.connected,
  });

  List<dynamic> connectRequests;
  String phone;
  String id;
  List<Connected> connected;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        connectRequests:
            List<dynamic>.from(json["connect_requests"].map((x) => x)),
        phone: json["phone"],
        id: json["_id"],
        connected: List<Connected>.from(
            json["connected"].map((x) => Connected.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "connect_requests": List<dynamic>.from(connectRequests.map((x) => x)),
        "phone": phone,
        "_id": id,
        "connected": List<dynamic>.from(connected.map((x) => x.toMap())),
      };
}

class Connected {
  Connected({
    required this.guardian,
    required this.location,
    required this.id,
    required this.phone,
    required this.profileCompletion,
    required this.device,
    required this.accountType,
    required this.isBlocked,
    required this.creationIp,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.updationIp,
    required this.bio,
    required this.connectedUsers,
    required this.dob,
    required this.gender,
    required this.handicapType,
    required this.name,
    required this.notifications,
    required this.pendingGuradianConnection,
    required this.profileImages,
    required this.profileVerified,
    required this.username,
  });

  Guardian guardian;
  Location location;
  String id;
  String phone;
  int profileCompletion;
  List<Device> device;
  String accountType;
  bool isBlocked;
  String creationIp;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String updationIp;
  String bio;
  List<dynamic> connectedUsers;
  DateTime dob;
  String gender;
  String handicapType;
  String name;
  List<Notification> notifications;
  List<dynamic> pendingGuradianConnection;
  List<dynamic> profileImages;
  bool profileVerified;
  String username;

  factory Connected.fromMap(Map<String, dynamic> json) => Connected(
        guardian: Guardian.fromMap(json["guardian"]),
        location: Location.fromMap(json["location"]),
        id: json["_id"],
        phone: json["phone"],
        profileCompletion: json["profile_completion"],
        device: List<Device>.from(json["device"].map((x) => Device.fromMap(x))),
        accountType: json["account_type"],
        isBlocked: json["is_blocked"],
        creationIp: json["creation_ip"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
        updationIp: json["updation_ip"],
        bio: json["bio"],
        connectedUsers:
            List<dynamic>.from(json["connected_users"].map((x) => x)),
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        handicapType: json["handicap_type"],
        name: json["name"],
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromMap(x))),
        pendingGuradianConnection: List<dynamic>.from(
            json["pending_guradian_connection"].map((x) => x)),
        profileImages: List<dynamic>.from(json["profile_images"].map((x) => x)),
        profileVerified: json["profile_verified"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "guardian": guardian.toMap(),
        "location": location.toMap(),
        "_id": id,
        "phone": phone,
        "profile_completion": profileCompletion,
        "device": List<dynamic>.from(device.map((x) => x.toMap())),
        "account_type": accountType,
        "is_blocked": isBlocked,
        "creation_ip": creationIp,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "updation_ip": updationIp,
        "bio": bio,
        "connected_users": List<dynamic>.from(connectedUsers.map((x) => x)),
        "dob": dob.toIso8601String(),
        "gender": gender,
        "handicap_type": handicapType,
        "name": name,
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toMap())),
        "pending_guradian_connection":
            List<dynamic>.from(pendingGuradianConnection.map((x) => x)),
        "profile_images": List<dynamic>.from(profileImages.map((x) => x)),
        "profile_verified": profileVerified,
        "username": username,
      };
}

class Device {
  Device({
    required this.fcm,
    required this.token,
    required this.lastLogin,
    required this.loginIp,
  });

  String fcm;
  String token;
  DateTime lastLogin;
  String loginIp;

  factory Device.fromMap(Map<String, dynamic> json) => Device(
        fcm: json["fcm"],
        token: json["token"],
        lastLogin: DateTime.parse(json["last_login"]),
        loginIp: json["login_ip"],
      );

  Map<String, dynamic> toMap() => {
        "fcm": fcm,
        "token": token,
        "last_login": lastLogin.toIso8601String(),
        "login_ip": loginIp,
      };
}

class Guardian {
  Guardian({
    required this.phone,
    required this.status,
    required this.id,
  });

  String phone;
  String status;
  String id;

  factory Guardian.fromMap(Map<String, dynamic> json) => Guardian(
        phone: json["phone"],
        status: json["status"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "phone": phone,
        "status": status,
        "id": id,
      };
}

class Location {
  Location({
    required this.coordinates,
    required this.type,
  });

  List<double> coordinates;
  String type;

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class Notification {
  Notification({
    required this.title,
    required this.body,
    required this.type,
    required this.requestId,
  });

  String title;
  String body;
  dynamic type;
  dynamic requestId;

  factory Notification.fromMap(Map<String, dynamic> json) => Notification(
        title: json["title"],
        body: json["body"],
        type: json["type"],
        requestId: json["request_id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "body": body,
        "type": type,
        "request_id": requestId,
      };
}

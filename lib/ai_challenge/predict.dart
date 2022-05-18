import 'package:body_detection/models/pose.dart';
import 'package:body_detection/models/pose_landmark_type.dart';
import 'package:body_detection/models/point3d.dart';
import 'package:flutter/foundation.dart';

abstract class Predict extends ValueNotifier {
  Predict(value) : super(value);
  void predict(Pose pose);
}

class HandExcersie extends Predict {
  HandExcersie() : super(null);
  bool handUp = false;
  @override
  void predict(Pose pose) {
    Point3d? leftShoulder,
        rightShoulder,
        rightWrist,
        leftWrist,
        leftElbow,
        rightElbow;
    for (var landmarks in pose.landmarks) {
      if (landmarks.type == PoseLandmarkType.leftShoulder) {
        leftShoulder = landmarks.position;
      } else if (landmarks.type == PoseLandmarkType.rightShoulder) {
        rightShoulder = landmarks.position;
      } else if (landmarks.type == PoseLandmarkType.rightWrist) {
        rightWrist = landmarks.position;
      } else if (landmarks.type == PoseLandmarkType.leftWrist) {
        leftWrist = landmarks.position;
      } else if (landmarks.type == PoseLandmarkType.leftElbow) {
        leftElbow = landmarks.position;
      } else if (landmarks.type == PoseLandmarkType.rightElbow) {
        rightElbow = landmarks.position;
      }
    }
    if (leftElbow != null && leftWrist != null && leftShoulder != null) {
      final hDiff = (leftShoulder.y - leftElbow.y).abs();
      final xDiff = (leftElbow.x - leftWrist.x).abs();

//hDiff -153.64764404296875 xDiff -89.208740234375 zDiff 284.9253845214844
      if (!handUp) {
        if (leftElbow.y + 40 < leftShoulder.y &&
            leftElbow.y > leftWrist.y &&
            xDiff < 50) {
          handUp = true;
        }
      }
      if (handUp) {
        if (leftElbow.y > leftShoulder.y &&
            leftElbow.y < leftWrist.y &&
            xDiff < 50) {
          handUp = false;
          notifyListeners();
        }
      }
    }
  }
}

class HandLegExcerise extends Predict {
  bool isUp = true;

  HandLegExcerise() : super("");
  @override
  void predict(Pose pose) {
    Point3d? leftShoulder,
        rightShoulder,
        rightWrist,
        leftWrist,
        leftElbow,
        rightElbow;
  }
}

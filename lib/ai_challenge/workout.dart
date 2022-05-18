import 'package:body_detection/body_detection.dart';
import 'package:body_detection/models/image_result.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection/models/pose_landmark_type.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'predict.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  Widget? _cameraImage;
  Size? _imageSize;
  Pose? pose;
  late HandExcersie handExcersie;
  bool connected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  void dispose() {
    BodyDetection.enablePoseDetection();
    BodyDetection.stopCameraStream();
    super.dispose();
  }

  void _init() async {
    bool result = await checkPermission();
    if (result) {
      handExcersie = HandExcersie();

      await BodyDetection.enablePoseDetection();
      await BodyDetection.startCameraStream(
        onFrameAvailable: (ImageResult image) {
          _handleCameraImage(image);
        },
        onPoseAvailable: (Pose? p) {
          if (p != null) {
            setState(() {
              pose = p;
            });
            handExcersie.predict(p);
          }
        },
      );

      //when ever pose dettected this function will be automatically called.
      handExcersie.addListener(() {});
    } else {
      debugPrint("Camera access denied");
    }
  }

  Future<bool> checkPermission() async {
    var status = await Permission.camera.status;
    while (status.isDenied) {
      status = await Permission.contacts.request();
      if (status.isPermanentlyDenied) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () async {
        //   if (!_start) {
        //     await BodyDetection.enablePoseDetection();
        //     await BodyDetection.startCameraStream(
        //       onFrameAvailable: (ImageResult image) {
        //         _handleCameraImage(image);
        //       },
        //       onPoseAvailable: (Pose? p) {
        //         if (p != null) {
        //           setState(() {
        //             pose = p;
        //           });
        //           handExcersie.predict(p);
        //         }
        //       },
        //       onMaskAvailable: (_) {},
        //     );
        //   } else {
        //     await BodyDetection.disablePoseDetection();
        //     await BodyDetection.stopCameraStream();
        //   }

        //   _start = !_start;
        // }),
        body: !connected
            ? const CircularProgressIndicator()
            : Stack(
                alignment: Alignment.center,
                children: [
                  _cameraImage ?? Offstage(),
                  pose != null
                      ? CustomPaint(
                          size: MediaQuery.of(context).size,
                          painter:
                              PosePainter(pose: pose!, imageSize: _imageSize!),
                        )
                      : Offstage(),
                ],
              ),
      ),
    );
  }

  void _handleCameraImage(ImageResult result) {
    // Ignore callback if navigated out of the page.
    if (!mounted) return;

    // To avoid a memory leak issue.
    // https://github.com/flutter/flutter/issues/60160
    PaintingBinding.instance?.imageCache?.clear();
    PaintingBinding.instance?.imageCache?.clearLiveImages();

    final image = Image.memory(
      result.bytes,
      gaplessPlayback: true,
      height: Get.height,
      width: Get.width,
      fit: BoxFit.fill,
    );

    setState(() {
      _cameraImage = image;
      _imageSize = result.size;
    });
  }
}

class PosePainter extends CustomPainter {
  PosePainter({
    required this.pose,
    required this.imageSize,
  });

  final Pose pose;
  final Size imageSize;
  final circlePaint = Paint()..color = const Color.fromRGBO(0, 255, 0, 0.8);
  final linePaint = Paint()
    ..color = const Color.fromRGBO(255, 0, 0, 0.8)
    ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    final double hRatio =
        imageSize.width == 0 ? 1 : size.width / imageSize.width;
    final double vRatio =
        imageSize.height == 0 ? 1 : size.height / imageSize.height;

    offsetForPart(part) =>
        Offset(part.position.x * hRatio, part.position.y * vRatio);

    for (final part in pose.landmarks) {
      canvas.drawCircle(offsetForPart(part), 5, circlePaint);

      // Draw text label for the landmark.
      TextSpan span = TextSpan(
        text: part.type.toString().substring(16),
        style: const TextStyle(
          color: Color.fromRGBO(0, 128, 255, 1),
          fontSize: 10,
        ),
      );
      TextPainter tp = TextPainter(text: span, textAlign: TextAlign.left);
      tp.textDirection = TextDirection.ltr;
      tp.layout();
      tp.paint(canvas, offsetForPart(part));
    }

    // Draw connections between the landmarks.
    final landmarksByType = {for (final it in pose.landmarks) it.type: it};
    for (final connection in connections) {
      final point1 = offsetForPart(landmarksByType[connection[0]]!);
      final point2 = offsetForPart(landmarksByType[connection[1]]!);
      canvas.drawLine(point1, point2, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  List<List<PoseLandmarkType>> get connections => [
        [PoseLandmarkType.leftEar, PoseLandmarkType.leftEyeOuter],
        [PoseLandmarkType.leftEyeOuter, PoseLandmarkType.leftEye],
        [PoseLandmarkType.leftEye, PoseLandmarkType.leftEyeInner],
        [PoseLandmarkType.leftEyeInner, PoseLandmarkType.nose],
        [PoseLandmarkType.nose, PoseLandmarkType.rightEyeInner],
        [PoseLandmarkType.rightEyeInner, PoseLandmarkType.rightEye],
        [PoseLandmarkType.rightEye, PoseLandmarkType.rightEyeOuter],
        [PoseLandmarkType.rightEyeOuter, PoseLandmarkType.rightEar],
        [PoseLandmarkType.mouthLeft, PoseLandmarkType.mouthRight],
        [PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder],
        [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip],
        [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip],
        [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow],
        [PoseLandmarkType.rightWrist, PoseLandmarkType.rightElbow],
        [PoseLandmarkType.rightWrist, PoseLandmarkType.rightThumb],
        [PoseLandmarkType.rightWrist, PoseLandmarkType.rightIndexFinger],
        [PoseLandmarkType.rightWrist, PoseLandmarkType.rightPinkyFinger],
        [PoseLandmarkType.leftHip, PoseLandmarkType.rightHip],
        [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
        [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
        [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle],
        [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle],
        [PoseLandmarkType.leftElbow, PoseLandmarkType.leftShoulder],
        [PoseLandmarkType.leftWrist, PoseLandmarkType.leftElbow],
        [PoseLandmarkType.leftWrist, PoseLandmarkType.leftThumb],
        [PoseLandmarkType.leftWrist, PoseLandmarkType.leftIndexFinger],
        [PoseLandmarkType.leftWrist, PoseLandmarkType.leftPinkyFinger],
        [PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHeel],
        [PoseLandmarkType.leftAnkle, PoseLandmarkType.leftToe],
        [PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHeel],
        [PoseLandmarkType.rightAnkle, PoseLandmarkType.rightToe],
        [PoseLandmarkType.rightHeel, PoseLandmarkType.rightToe],
        [PoseLandmarkType.leftHeel, PoseLandmarkType.leftToe],
        [PoseLandmarkType.rightIndexFinger, PoseLandmarkType.rightPinkyFinger],
        [PoseLandmarkType.leftIndexFinger, PoseLandmarkType.leftPinkyFinger],
      ];
}

import 'dart:io' as io;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'camera_view.dart';
import 'painters/coordinates_translator.dart';
import 'painters/object_detector_painter.dart';

class ObjectDetectorView extends StatefulWidget {
  @override
  _ObjectDetectorView createState() => _ObjectDetectorView();
}

class _ObjectDetectorView extends State<ObjectDetectorView> {
  late ObjectDetector _objectDetector;
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  late FlutterTts flutterTts;
  bool _cooling = false;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setLanguage("en-US");
    flutterTts.setPitch(1);
    flutterTts.setSpeechRate(0.32);
    _initializeDetector();
  }

  List<String> common = ["electronicdevice", "container", "furniture"];
  Map<String, String> replaceName = {"glove": "hand"};

  @override
  void dispose() {
    _canProcess = false;
    _objectDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Object Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      initialDirection: CameraLensDirection.back,
    );
  }

  void _initializeDetector() async {
    // uncomment next lines if you want to use the default model
    // final options =
    //     ObjectDetectorOptions(classifyObjects: true, multipleObjects: true);
    // _objectDetector = ObjectDetector(options: options);

    // uncomment next lines if you want to use a local model
    // make sure to add tflite model to assets/ml
    const path = 'assets/ml/object_labeler.tflite';
    final modelPath = await _getModel(path);
    final options = LocalObjectDetectorOptions(
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );
    _objectDetector = ObjectDetector(options: options);

    // uncomment next lines if you want to use a remote model
    // make sure to add model to firebase
    // final modelName = 'bird-classifier';
    // final response =
    //     await FirebaseObjectDetectorModelManager().downloadModel(modelName);
    // print('Downloaded: $response');
    // final options = FirebaseObjectDetectorOptions(
    //   modelName: modelName,
    //   classifyObjects: true,
    //   multipleObjects: true,
    // );
    // _objectDetector = ObjectDetector(options: options);

    _canProcess = true;
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final objects = await _objectDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = ObjectDetectorPainter(
          objects,
          inputImage.inputImageData!.imageRotation,
          inputImage.inputImageData!.size, onCreated: (obj) {
        if (!_cooling) {
          _getSpeechOutput(
            obj,
          );
        }
      });
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Objects found: ${objects.length}\n\n';
      for (final object in objects) {
        text +=
            'Object:  trackingId: ${object.trackingId} - ${object.labels.map((e) => e.text)}\n\n';
      }
      _text = text;

      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<String> _getModel(String assetPath) async {
    if (io.Platform.isAndroid) {
      return 'flutter_assets/$assetPath';
    }
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await io.Directory(dirname(path)).create(recursive: true);
    final file = io.File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  void _getSpeechOutput(
    List<DetectedObject> objects,
  ) async {
    List<String> identified = [];
    for (DetectedObject object in objects) {
      Label highestConfidenece = Label(text: "", confidence: 0, index: 0);
      bool added = false;
      for (var label in object.labels) {
        if (label.confidence > highestConfidenece.confidence &&
            !common.contains(label.text.toLowerCase().replaceFirst(" ", ""))) {
          String a = label.text.toLowerCase();

          a = replaceName[a] ?? a;

          highestConfidenece = label;
          identified.add(a);
          added = true;
        }
      }
      if (!added && object.labels.isNotEmpty) {
        identified.add(object.labels[0].text.toLowerCase());
      }
    }

    String text = "";
    var map = {};

    identified.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });

    for (int i = 0; i < identified.length; i++) {
      final word = identified[i];
      if (i == 0) {
        if (map[word] > 1) {
          text += "There are ${map[word]} $word ";
        } else {
          text += "There is a $word ";
        }
      } else if (i == identified.length - 1) {
        if (map[word] > 1) {
          text += " and ${map[word]} $word ";
        } else {
          text += "and a $word";
        }
      } else {
        if (map[word] > 1) {
          text += " ${map[word]} $word";
        } else {
          text += "a $word";
        }
      }
    }

    if (text.isNotEmpty) {
      _cooling = true;

      await flutterTts.speak(text);

      await Future.delayed(const Duration(seconds: 4, milliseconds: 500));
      _cooling = false;
    }
  }
}

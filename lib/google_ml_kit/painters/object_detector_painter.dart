import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

import 'coordinates_translator.dart';

class ObjectDetectorPainter extends CustomPainter {
  ObjectDetectorPainter(this._objects, this.rotation, this.absoluteSize,
      {this.onCreated});

  final List<DetectedObject> _objects;
  final Size absoluteSize;
  final InputImageRotation rotation;
  final Function(List<DetectedObject>)? onCreated;
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint background = Paint()..color = Color(0x99000000);
    final screenCenter = Offset(Get.width * 0.5, Get.height * 0.5);
    List<DetectedObject> _objs = [];

    for (final DetectedObject detectedObject in _objects) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(
          ui.TextStyle(color: Colors.lightGreenAccent, background: background));

      for (final Label label in detectedObject.labels) {
        builder.addText('${label.text} ${label.confidence}\n');
      }

      builder.pop();
      // final boxCenter = Offset(
      //   detectedObject.boundingBox.left,
      //   detectedObject.boundingBox.top,
      // );
      // final boxCenter = detectedObject.boundingBox.center;
      // final distance = (screenCenter - boxCenter).distance;
      // if (distance <= 300) {
      final left = translateX(
          detectedObject.boundingBox.left, rotation, size, absoluteSize);
      final top = translateY(
          detectedObject.boundingBox.top, rotation, size, absoluteSize);
      final right = translateX(
          detectedObject.boundingBox.right, rotation, size, absoluteSize);
      final bottom = translateY(
          detectedObject.boundingBox.bottom, rotation, size, absoluteSize);
      final boxCenter = Offset((left + right) / 2, (top + bottom) / 2);

      if ((boxCenter - screenCenter).distance <= 100) {
        _objs.add(detectedObject);
        canvas.drawRect(
          Rect.fromLTRB(left, top, right, bottom),
          paint,
        );

        canvas.drawParagraph(
          builder.build()
            ..layout(ParagraphConstraints(
              width: right - left,
            )),
          Offset(left, top),
        );
      }
    }
    if (onCreated != null) {
      onCreated!(_objs);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

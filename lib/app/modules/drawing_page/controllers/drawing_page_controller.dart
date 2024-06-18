import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/model.dart';

class DrawingPageController extends GetxController {
  RxString svgPath = RxString('');
  RxnInt selectedColorIndex = RxnInt();
  RxList<SingleLineDrawingData?> historyDrawingPoints =
      <SingleLineDrawingData>[].obs;
  RxList<SingleLineDrawingData?> drawingPoints = <SingleLineDrawingData>[].obs;

  Rx<Color?> selectedColor = Colors.black.obs;
  RxDouble? selectedWidth = 20.0.obs;
  RxBool? isEraser = false.obs;

  late SingleLineDrawingData? currentDrawingPoint;

  @override
  void onInit() {
    super.onInit();
    svgPath.value = Get.parameters['svgPath'] ?? '';
  }
}

class DrawingPainter extends CustomPainter {
  final List<SingleLineDrawingData?> drawingPoints;
  // final Path svgPath;

  DrawingPainter({
    required this.drawingPoints,
    required Listenable repaint,
    // required this.svgPath,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate((size.width / 2) - 150, (size.height / 2) - 150);
    // canvas.clipPath(svgPath);
    // canvas.drawPath(
    //   svgPath,
    //   Paint()
    //     ..style = PaintingStyle.stroke
    //     ..color = Colors.black
    //     ..isAntiAlias = true
    //     ..strokeWidth = 5,
    // );
    canvas.translate(-((size.width / 2) - 150), -((size.height / 2) - 150));
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    for (var drawingPoint in drawingPoints) {
      if (drawingPoint != null) {
        final paint = Paint()
          ..color = drawingPoint.color
          ..isAntiAlias = true
          ..strokeWidth = drawingPoint.width
          ..strokeCap = StrokeCap.round
          ..blendMode =
              drawingPoint.eraser ? BlendMode.clear : BlendMode.srcOver;

        for (var i = 0; i < drawingPoint.offsets.length; i++) {
          var notLastOffset = i != drawingPoint.offsets.length - 1;

          if (notLastOffset) {
            final current = drawingPoint.offsets[i];
            final next = drawingPoint.offsets[i + 1];
            canvas.drawLine(current, next, paint);
          } else {
            canvas.drawPoints(PointMode.points, drawingPoint.offsets, paint);
          }
        }
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

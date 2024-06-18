import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import '../model/model.dart';
import 'vector.dart';

class DrawingPageController extends GetxController {
  RxString svgPath = RxString('');
  RxnInt selectedColorIndex = RxnInt();
  RxList<SingleLineDrawingData?> historyDrawingPoints =
      RxList.empty(growable: true);
  RxList<SingleLineDrawingData?> drawingPoints = RxList.empty(growable: true);

  Rx<Color?> selectedColor = Colors.black.obs;
  RxDouble? selectedWidth = 20.0.obs;
  RxBool? isEraser = false.obs;
  RxString? pathData = RxString('');
  late Path applePath;
  late SingleLineDrawingData? currentDrawingPoint;

  @override
  Future<void> onInit() async {
    super.onInit();
    svgPath.value = Get.parameters['svgPath'] ?? '';
    svgPath.value =
        '/Volumes/code/delete/cope/hope/Testing/landf/eso_akte_sikhi/assets/art_objs/test.svg';
    pathData?.value = await extractPathData(svgPath.value) ?? '';
    pathData?.value = scaleSvgPath(pathData?.value ?? '', Get.width);
    applePath = parseSvgPath(pathData?.value ?? '');
    // print(pathData?.value);
  }

  Future<String?> extractPathData(String assetPath) async {
    try {
      // Load the SVG file as a string
      String svgData = await rootBundle.loadString(assetPath);

      // Use a regular expression to extract the path data
      RegExp regExp = RegExp(r'<path d="([^"]+)"');
      RegExpMatch? match = regExp.firstMatch(svgData);

      if (match != null) {
        String? pathData = match.group(1);
        return pathData;
      } else {
        return 'No path data found';
      }
    } catch (e) {
      return 'Error reading file: $e';
    }
  }
}

class DrawingPainter extends CustomPainter {
  final List<SingleLineDrawingData?> drawingPoints;
  final Path svgPath;

  DrawingPainter({
    required this.drawingPoints,
    required Listenable repaint,
    required this.svgPath,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate((size.width / 2) - 150, (size.height / 3) - 150);
    canvas.clipPath(svgPath);
    canvas.drawPath(
      svgPath,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.black
        ..isAntiAlias = true
        ..strokeWidth = 5,
    );
    canvas.translate(-((size.width / 2) - 150), -((size.height / 3) - 150));
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

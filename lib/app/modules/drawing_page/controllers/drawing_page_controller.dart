// Imports for Flutter, GetX, and SVG parsing
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../model/model.dart';
import 'vector.dart';

// Controller that manages drawing logic
class DrawingPageController extends GetxController {
  // Holds the path to the SVG file
  RxString svgPath = RxString('');

  // Tracks user’s selected color index; null if none chosen
  RxnInt selectedColorIndex = RxnInt();

  // Stores the lines drawn so far
  RxList<SingleLineDrawingData?> historyDrawingPoints =
      RxList.empty(growable: true);

  // Stores in-progress drawing lines
  RxList<SingleLineDrawingData?> drawingPoints = RxList.empty(growable: true);

  // The chosen color
  Rx<Color?> selectedColor = Colors.black.obs;

  // The chosen line width
  RxDouble? selectedWidth = 20.0.obs;

  // True if currently using the eraser
  RxBool? isEraser = false.obs;

  // The SVG path data (the "d" attribute)
  RxString? pathData = RxString('');

  // These hold the original height/width from SVG
  RxString? heightSVG = RxString('');
  RxString? widhthSVG = RxString('');

  // These convert height/width to numeric form
  RxDouble? hsvg = 0.0.obs;
  RxDouble? wsvg = 0.0.obs;

  // Parsed path object and the current drawing point
  late Path applePath;
  late SingleLineDrawingData? currentDrawingPoint;

  @override
  Future<void> onInit() async {
    super.onInit();

    // Retrieve SVG info passed in or use hard-coded path
    svgPath.value = Get.parameters['svgPath'] ?? '';
    svgPath.value =
        '/Volumes/code/delete/cope/hope/Testing/landf/eso_akte_sikhi/assets/art_objs/test.svg';

    // Extract SVG height, width, and path data
    heightSVG?.value = await extractHeight(svgPath.value) ?? '';
    widhthSVG?.value = await extractWidhth(svgPath.value) ?? '';
    wsvg?.value = double.tryParse(widhthSVG?.value ?? '') ?? 0;
    hsvg?.value = double.tryParse(heightSVG?.value ?? '') ?? 0;
    pathData?.value = await extractPathData(svgPath.value) ?? '';

    // Scale SVG path to fit screen height
    pathData?.value = scaleSvgPath(
        pathData?.value ?? '', (Get.height / 3 / (hsvg?.toInt() ?? 1)));

    // Parse the SVG path into a Path object
    applePath = parseSvgPath(pathData?.value ?? '');
  }

  // Reads the file, extracts the "d" attribute
  Future<String?> extractPathData(String assetPath) async {
    try {
      String svgData = await rootBundle.loadString(assetPath);
      RegExp regExp = RegExp(r'<path d="([^"]+)"');
      RegExpMatch? match = regExp.firstMatch(svgData);
      if (match != null) {
        return match.group(1);
      } else {
        return 'No path data found';
      }
    } catch (e) {
      return 'Error reading file: $e';
    }
  }

  // Reads the file, finds the height attribute
  Future<String?> extractHeight(String assetPath) async {
    try {
      String svgData = await rootBundle.loadString(assetPath);
      RegExp regExp = RegExp(r'height="([^"]+)"');
      RegExpMatch? match = regExp.firstMatch(svgData);
      if (match != null) {
        return match.group(1);
      } else {
        return 'No height data found';
      }
    } catch (e) {
      return 'Error reading file: $e';
    }
  }

  // Reads the file, finds the width attribute
  Future<String?> extractWidhth(String assetPath) async {
    try {
      String svgData = await rootBundle.loadString(assetPath);
      RegExp regExp = RegExp(r'width="([^"]+)"');
      RegExpMatch? match = regExp.firstMatch(svgData);
      if (match != null) {
        return match.group(1);
      } else {
        return 'No w data found';
      }
    } catch (e) {
      return 'Error reading file: $e';
    }
  }
}

// Painter that draws the SVG outline and user-drawn lines
class DrawingPainter extends CustomPainter {
  final List<SingleLineDrawingData?> drawingPoints;
  final Path svgPath;
  final double wsvg;
  final double hsvg;

  DrawingPainter({
    required this.wsvg,
    required this.hsvg,
    required this.drawingPoints,
    required Listenable repaint,
    required this.svgPath,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    // Translate and clip canvas to the shape of the SVG
    double k = wsvg + 30, l = hsvg - 60;
    canvas.translate((size.width / 2) - k, (size.height / 3) - l);
    canvas.clipPath(svgPath);

    // Optionally draw the SVG path outline
    canvas.drawPath(
      svgPath,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.black
        ..isAntiAlias = true
        ..strokeWidth = 5,
    );

    // Shift it back and prepare for drawing new lines
    canvas.translate(-((size.width / 2) - k), -((size.height / 3) - l));
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // Draw each line in the drawingPoints list
    for (var drawingPoint in drawingPoints) {
      if (drawingPoint != null) {
        final paint = Paint()
          ..color = drawingPoint.color
          ..isAntiAlias = true
          ..strokeWidth = drawingPoint.width
          ..strokeCap = StrokeCap.round
          ..blendMode =
              drawingPoint.eraser ? BlendMode.clear : BlendMode.srcOver;

        // Connect offset points or draw single dots
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
    // Cleanup
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Redraw every time new data is provided
    return true;
  }
}

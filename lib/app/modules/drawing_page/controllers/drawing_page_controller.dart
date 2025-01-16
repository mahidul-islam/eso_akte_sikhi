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
        '/Volumes/code/myProjects/eso_akte_sikhi/Assets/art_objs/test.svg';

    // Extract SVG height, width, and path data
    heightSVG?.value = await extractHeight(svgPath.value) ?? '';
    widhthSVG?.value = await extractWidhth(svgPath.value) ?? '';
    wsvg?.value = double.tryParse(widhthSVG?.value ?? '') ?? 0;
    hsvg?.value = double.tryParse(heightSVG?.value ?? '') ?? 0;
    pathData?.value = await extractPathData(svgPath.value) ?? '';

    // Scale SVG path to fit screen height
    // This is implemented in the vector.dart file
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
  final List<SingleLineDrawingData?> drawingPoints; // List of user-drawn lines
  final Path svgPath; // Path of the SVG outline
  final double wsvg; // Width of the SVG
  final double hsvg; // Height of the SVG

  DrawingPainter({
    required this.wsvg,
    required this.hsvg,
    required this.drawingPoints,
    required Listenable repaint,
    required this.svgPath,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate translation values
    double k = wsvg + 30, l = hsvg - 60;
    // Move the canvas to center the SVG
    canvas.translate((size.width / 2) - k, (size.height / 3) - l);
    // Clip the canvas to the SVG path
    canvas.clipPath(svgPath);

    // Draw the SVG path outline
    canvas.drawPath(
      svgPath,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.black
        ..isAntiAlias = true
        ..strokeWidth = 5,
    );

    // Reset the translation
    canvas.translate(-((size.width / 2) - k), -((size.height / 3) - l));
    // Save the current layer
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    for (var drawingPoint in drawingPoints) {
      // Iterate over each point in the drawingPoints list
      if (drawingPoint != null) {
        // Check if the current drawingPoint is not null
        final paint = Paint() // Create a new Paint object for drawing
          ..color = drawingPoint
              .color // Set the paint color to the drawingPoint's color
          ..isAntiAlias = true // Enable anti-aliasing for smoother edges
          ..strokeWidth = drawingPoint
              .width // Set the stroke width based on drawingPoint's width
          ..strokeCap = StrokeCap
              .round // Set the stroke cap to round for rounded line endings
          ..blendMode = drawingPoint.eraser
              ? BlendMode.clear
              : BlendMode
                  .srcOver; // Use clear blend mode if eraser is active, otherwise default blend mode

        // Draw lines or points based on the offsets
        for (var i = 0; i < drawingPoint.offsets.length; i++) {
          // Loop through each offset in drawingPoint
          var notLastOffset = i !=
              drawingPoint.offsets.length -
                  1; // Check if the current offset is not the last one
          if (notLastOffset) {
            // If it's not the last offset
            final current = drawingPoint.offsets[i]; // Get the current offset
            final next = drawingPoint.offsets[i + 1]; // Get the next offset
            canvas.drawLine(current, next,
                paint); // Draw a line segment from current to next
          } else {
            // If it is the last offset
            canvas.drawPoints(PointMode.points, drawingPoint.offsets,
                paint); // Draw a single point
          }
        }
      }
    }
    // Restore the canvas to its previous state
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Always repaint when new data is provided
    return true;
  }
}

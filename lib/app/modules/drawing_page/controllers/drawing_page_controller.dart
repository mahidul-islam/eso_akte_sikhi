import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/model.dart';

class DrawingPageController extends GetxController {
  RxString svgPath = RxString('');
  RxnInt selectedColorIndex = RxnInt();
  RxList<SingleLineDrawingData?> historyDrawingPoints =
      RxList.empty(growable: true);
  RxList<SingleLineDrawingData?> drawingPoints = RxList.empty(growable: true);

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

// Imports Flutter, various assets, and the controller
import 'dart:math';
import 'package:eso_akte_sikhi/app/routes/app_pages.dart';
import 'package:eso_akte_sikhi/app/shared/const/colors.dart';
import 'package:eso_akte_sikhi/app/shared/const/image_asset.dart';
import 'package:eso_akte_sikhi/app/shared/const/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/drawing_page_controller.dart';
import '../model/model.dart';

// The main View class for drawing
class DrawingPageView extends GetView<DrawingPageController> {
  const DrawingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold with custom app bar and body
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          // Outer container with a margin and background color
          margin: const EdgeInsets.fromLTRB(10, 60, 10, 0),
          decoration: const BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            border: Border(
              bottom: BorderSide(color: Colors.purpleAccent, width: 10.0),
              right: BorderSide(color: Colors.purpleAccent, width: 10.0),
              left: BorderSide(color: Colors.purpleAccent, width: 10.0),
            ),
          ),
          child: Container(
            // Inner container with another background, forming a layered look
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              border: Border(
                bottom: BorderSide(color: Colors.orange, width: 10.0),
                right: BorderSide(color: Colors.orange, width: 10.0),
                left: BorderSide(color: Colors.orange, width: 10.0),
              ),
            ),
            child: Row(
              // Icon row for navigation and actions
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Back button
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(Routes.ITEM_LIST);
                  },
                  child: SvgPicture.asset(
                    SVGAsset.back,
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                // Clear/drawings button
                GestureDetector(
                  onTap: () {
                    controller.drawingPoints.clear();
                  },
                  child: SvgPicture.asset(
                    SVGAsset.delete,
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                // Undo button
                GestureDetector(
                  onTap: () {
                    controller.drawingPoints.removeLast();
                  },
                  child: SvgPicture.asset(
                    SVGAsset.undo,
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                // Redo button
                GestureDetector(
                  onTap: () {
                    if (controller.drawingPoints.length <
                        controller.historyDrawingPoints.length) {
                      final index = controller.drawingPoints.length;
                      controller.drawingPoints
                          .add(controller.historyDrawingPoints[index]);
                    }
                  },
                  child: SvgPicture.asset(
                    SVGAsset.redo,
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                // Download icon (not implemented yet)
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    SVGAsset.download,
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                // Share icon (not implemented yet)
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    SVGAsset.share,
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Body uses Rx (Obx) for reactive UI updates
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              // GestureDetector for capturing drawing events
              child: GestureDetector(
                onPanStart: (details) {
                  // Create a new SingleLineDrawingData object on start
                  controller.currentDrawingPoint = SingleLineDrawingData(
                    id: DateTime.now().microsecondsSinceEpoch,
                    offsets: [
                      details.localPosition,
                    ],
                    color: EASColors.selectedColor[
                        controller.selectedColorIndex.value ?? 0],
                    width: controller.selectedWidth?.value ?? 0,
                    eraser: controller.isEraser?.value ?? false,
                  );

                  // Add the newly created drawingPoint to the list
                  if (controller.currentDrawingPoint == null) return;
                  controller.drawingPoints.add(controller.currentDrawingPoint);
                  // Update the history
                  controller.historyDrawingPoints.clear();
                  controller.historyDrawingPoints
                      .addAll(controller.drawingPoints);
                },
                onPanUpdate: (details) {
                  // Continually add new offsets to the current line
                  if (controller.currentDrawingPoint == null) return;
                  controller.currentDrawingPoint =
                      controller.currentDrawingPoint?.copyWith(
                    offsets: controller.currentDrawingPoint!.offsets
                      ..add(details.localPosition),
                  );
                  controller.drawingPoints.last =
                      controller.currentDrawingPoint!;
                  // Keep the history in sync
                  controller.historyDrawingPoints.clear();
                  controller.historyDrawingPoints
                      .addAll(controller.drawingPoints);
                },
                onPanEnd: (_) {
                  // End current drawing stroke
                  controller.currentDrawingPoint = null;
                },
                child: ColoredBox(
                  color: Colors.white,
                  child: CustomPaint(
                    painter: DrawingPainter(
                      // Paints the user’s drawn lines plus the SVG path
                      drawingPoints: controller.drawingPoints,
                      repaint: controller.drawingPoints.reactive,
                      svgPath: controller.applePath,
                      wsvg: controller.wsvg?.value ?? 0,
                      hsvg: controller.hsvg?.value ?? 0,
                    ),
                    child: SizedBox(
                      width: Get.width,
                      height: Get.height / 2,
                      child: Center(
                        // The underlying SVG image
                        child: SvgPicture.asset(
                          controller.svgPath.value,
                          width: Get.width / 2,
                          height: Get.height / 3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Color and eraser controls at the bottom
            Container(
              padding: const EdgeInsets.all(10),
              color: EASColors.orange.withOpacity(0.4),
              height: 90,
              child: Row(
                children: [
                  // Displays the current brush size/color or eraser icon
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    width: Get.width / 10,
                    height: Get.width / 10,
                    child: Center(
                      child: controller.isEraser?.value == false
                          ? Container(
                              // A circle that shows the chosen color / size
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: EASColors.selectedColor[
                                    controller.selectedColorIndex.value ?? 0],
                              ),
                              height: controller.selectedWidth?.value,
                              width: controller.selectedWidth?.value,
                            )
                          : SvgPicture.asset(
                              // Eraser icon
                              SVGAsset.rubber,
                              height: 30.0,
                              width: 30.0,
                            ),
                    ),
                  ),
                  // Slider changes the line width (non-linear scale)
                  Expanded(
                    child: SliderTheme(
                      data: const SliderThemeData(
                        trackHeight: 25,
                      ),
                      child: Slider(
                        value:
                            pow(controller.selectedWidth?.value ?? 0, 1 / 1.5)
                                .toDouble(),
                        min: 1,
                        max: 15,
                        onChanged: (value) {
                          controller.selectedWidth?.value =
                              pow(value, 1.5).toDouble();
                        },
                        activeColor: EASColors.violet.withOpacity(0.4),
                        inactiveColor: EASColors.violet.withOpacity(0.4),
                        thumbColor: EASColors.orange,
                      ),
                    ),
                  ),
                  GestureDetector(
                    // Toggle eraser mode on/off
                    onTap: () {
                      controller.isEraser?.value =
                          !(controller.isEraser?.value ?? false);
                    },
                    child: SvgPicture.asset(
                      SVGAsset.rubber,
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Example pan icon (no specific action here)
                  SvgPicture.asset(
                    SVGAsset.pan,
                    height: 30.0,
                    width: 30.0,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      // Bottom color palette for picking brush color
      bottomNavigationBar: Container(
        color: EASColors.lightReddish,
        height: 130 + Get.mediaQuery.padding.bottom,
        width: Get.width,
        padding: EdgeInsets.only(bottom: Get.mediaQuery.padding.bottom - 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (_, int index) {
              return Obx(() {
                // Display a color can that expands if selected
                return Column(
                  mainAxisAlignment:
                      controller.selectedColorIndex.value == index
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.isEraser?.value = false;
                        controller.selectedColorIndex.value = index;
                      },
                      child: Container(
                        margin: controller.selectedColorIndex.value == index
                            ? const EdgeInsets.only(right: 0)
                            : const EdgeInsets.only(right: 8),
                        width: controller.selectedColorIndex.value == index
                            ? 55
                            : 32,
                        height: controller.selectedColorIndex.value == index
                            ? 105
                            : 76,
                        child: Image.asset(
                          controller.selectedColorIndex.value == index
                              ? ImageAsset.opened_can
                              : ImageAsset.closed_can,
                          width: 32,
                          height: 64,
                          colorBlendMode: BlendMode.modulate,
                          color: EASColors.selectedColor[index],
                        ),
                      ),
                    ),
                  ],
                );
              });
            },
            itemCount: EASColors.selectedColor.length,
          ),
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:eso_akte_sikhi/app/modules/drawing_page/widget/drawing_painter.dart';
import 'package:eso_akte_sikhi/app/routes/app_pages.dart';
import 'package:eso_akte_sikhi/app/shared/const/colors.dart';
import 'package:eso_akte_sikhi/app/shared/const/image_asset.dart';
import 'package:eso_akte_sikhi/app/shared/const/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/drawing_page_controller.dart';
import '../model/model.dart';

class DrawingPageView extends GetView<DrawingPageController> {
  const DrawingPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    SVGAsset.download,
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
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
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: GestureDetector(
                onPanStart: (details) {
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

                  if (controller.currentDrawingPoint == null) return;
                  controller.drawingPoints.add(controller.currentDrawingPoint);
                  controller.historyDrawingPoints.clear();
                  controller.historyDrawingPoints
                      .addAll(controller.drawingPoints);
                },
                onPanUpdate: (details) {
                  if (controller.currentDrawingPoint == null) return;

                  controller.currentDrawingPoint =
                      controller.currentDrawingPoint?.copyWith(
                    offsets: controller.currentDrawingPoint!.offsets
                      ..add(details.localPosition),
                  );
                  controller.drawingPoints.last =
                      controller.currentDrawingPoint!;
                  controller.historyDrawingPoints.clear();
                  controller.historyDrawingPoints
                      .addAll(controller.drawingPoints);
                },
                onPanEnd: (_) {
                  controller.currentDrawingPoint = null;
                },
                child: ColoredBox(
                  color: Colors.white,
                  child: CustomPaint(
                    painter: DrawingPainter(
                      drawingPoints: controller.drawingPoints,
                      repaint: controller.drawingPoints.reactive,
                    ),
                    child: SizedBox(
                      width: Get.width,
                      height: Get.height / 2,
                      child: Center(
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
            // Expanded(

            // ),
            Container(
              padding: const EdgeInsets.all(10),
              color: EASColors.orange.withOpacity(0.4),
              height: 90,
              child: Row(
                children: [
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
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: EASColors.selectedColor[
                                    controller.selectedColorIndex.value ?? 0],
                              ),
                              height: controller.selectedWidth?.value,
                              width: controller.selectedWidth?.value,
                            )
                          : SvgPicture.asset(
                              SVGAsset.rubber,
                              height: 30.0,
                              width: 30.0,
                            ),
                    ),
                  ),
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
                        )),
                  ),
                  GestureDetector(
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
      bottomNavigationBar: Container(
        color: EASColors.lightReddish,
        height: 130 + Get.mediaQuery.padding.bottom,
        width: Get.width,
        padding: Get.mediaQuery.padding.bottom > 0
            ? EdgeInsets.only(bottom: Get.mediaQuery.padding.bottom - 10)
            : null,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (_, int index) {
              return Obx(() {
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

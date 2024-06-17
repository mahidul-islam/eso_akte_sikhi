import 'dart:math';
import 'dart:ui';

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
                  onTap: () {},
                  child: SvgPicture.asset(
                    SVGAsset.delete,
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    SVGAsset.undo,
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
      body: Column(
        children: [
          Expanded(
            child: SvgPicture.asset(
              controller.svgPath.value,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: EASColors.orange.withOpacity(0.4),
            height: 90,
            child: Row(
              children: [
                SvgPicture.asset(
                  SVGAsset.dot,
                  height: 30.0,
                  width: 30.0,
                ),
                Expanded(
                  child: SliderTheme(
                    data: const SliderThemeData(
                      trackHeight: 25,
                    ),
                    child: Obx(() {
                      return Slider(
                        value:
                            pow(controller.selectedWidth?.value ?? 0, 1 / 1.5)
                                .toDouble(),
                        min: 1,
                        max: 40,
                        onChanged: (value) {
                          controller.selectedWidth?.value =
                              pow(value, 1.5).toDouble();
                        },
                        activeColor: EASColors.violet.withOpacity(0.4),
                        inactiveColor: EASColors.violet.withOpacity(0.4),
                        thumbColor: EASColors.orange,
                      );
                    }),
                  ),
                ),
                SvgPicture.asset(
                  SVGAsset.rubber,
                  height: 30.1,
                  width: 30.0,
                ),
                const SizedBox(width: 4),
                SvgPicture.asset(
                  SVGAsset.pan,
                  height: 30.0,
                  width: 30.0,
                ),
              ],
            ),
          ),
        ],
      ),
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
                return Column(
                  mainAxisAlignment:
                      controller.selectedColorIndex.value == index
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
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

class DrawingPainter extends CustomPainter {
  final List<SingleLineDrawingData> drawingPoints;
  final Path svgPath;

  DrawingPainter({required this.drawingPoints, required this.svgPath});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate((size.width / 2) - 150, (size.height / 2) - 150);
    canvas.clipPath(svgPath);
    canvas.drawPath(
      svgPath,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.black
        ..isAntiAlias = true
        ..strokeWidth = 5,
    );
    canvas.translate(-((size.width / 2) - 150), -((size.height / 2) - 150));
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    for (var drawingPoint in drawingPoints) {
      final paint = Paint()
        ..color = drawingPoint.color
        ..isAntiAlias = true
        ..strokeWidth = drawingPoint.width
        ..strokeCap = StrokeCap.round
        ..blendMode = drawingPoint.eraser ? BlendMode.clear : BlendMode.srcOver;

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
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'package:eso_akte_sikhi/app/routes/app_pages.dart';
import 'package:eso_akte_sikhi/app/shared/const/colors.dart';
import 'package:eso_akte_sikhi/app/shared/const/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/drawing_page_controller.dart';

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
                    Get.toNamed(Routes.ITEM_LIST);
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
            child: Container(
              color: const Color.fromARGB(96, 211, 209, 209),
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
                    child: Slider(
                      activeColor: EASColors.violet.withOpacity(0.4),
                      inactiveColor: EASColors.violet.withOpacity(0.4),
                      thumbColor: EASColors.orange,
                      value: 3,
                      max: 20,
                      min: 0,
                      onChanged: (_) {},
                    ),
                  ),
                ),
                SvgPicture.asset(
                  SVGAsset.rubber,
                  height: 30.0,
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
        padding: EdgeInsets.only(bottom: Get.mediaQuery.padding.bottom),
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
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.selectedColorIndex.value = index;
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 32,
                        height: 76,
                        color: EASColors.selectedColor[index],
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

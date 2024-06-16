import 'package:eso_akte_sikhi/app/routes/app_pages.dart';
import 'package:eso_akte_sikhi/app/shared/const/image_asset.dart';
import 'package:eso_akte_sikhi/app/shared/const/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/widgets.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('HomeView'),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/mainback.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 13,
                ),
                SvgPicture.asset(
                  SVGAsset.main_icon,
                  width: 220,
                  height: 130,
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.ITEM_LIST);
                  },
                  child: Image.asset(
                    ImageAsset.play_ic,
                    height: Get.height / 7,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                Image.asset(
                  ImageAsset.main_center_image,
                  height: Get.height / 3,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(
                  height: Get.height / 30,
                ),
                Padding(
                  padding: EdgeInsets.all(Get.width / 12),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TwoBorderButton(
                        names: 'RATE APPS',
                      ),
                      TwoBorderButton(
                        names: 'MY DRAWING',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

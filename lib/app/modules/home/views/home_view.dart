import 'package:eso_akte_sikhi/app/routes/app_pages.dart';
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
              'Assets/mainback.png',
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
                  'Assets/drawingBook.svg',
                  width: 220,
                  height: 130,
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.EDITOR_PAGE);
                  },
                  child: Image.asset(
                    'Assets/maincenup.png',
                    height: Get.height / 7,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                Image.asset(
                  'Assets/maincenter.png',
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

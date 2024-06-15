import 'package:eso_akte_sikhi/app/routes/app_pages.dart';
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
                    'assets/edit_bar/back.svg',
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/edit_bar/bin.svg',
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/edit_bar/Undo.svg',
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/edit_bar/Redo.svg',
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/edit_bar/download.svg',
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/edit_bar/Share.svg',
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
              height: Get.height / 2,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xffFFA732),
            height: 90,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/edit_bar/Dot.svg',
                  height: 40.0,
                  width: 40.0,
                ),
                Slider(value: 3, max: 20, min: 0, onChanged: (_) {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}

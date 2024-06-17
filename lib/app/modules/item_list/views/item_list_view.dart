import 'package:eso_akte_sikhi/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../home/widgets/widgets.dart';
import '../controllers/item_list_controller.dart';

class ItemListView extends GetView<ItemListController> {
  const ItemListView({super.key});

  static const int numberOfImages = 8;

  List<String> get artObjPaths {
    return List<String>.generate(
      numberOfImages,
      (index) => 'assets/art_objs/artObj${index + 1}.svg',
    );
  }

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.HOME);
                        },
                        child: Image.asset(
                          'assets/backButton.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Tex(
                          rcvd: 'SELECT DRAWING',
                          fsize: 25,
                          colo: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          itemCount: artObjPaths.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Box(
              artObjPaths: artObjPaths,
              index: index,
            );
          },
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    super.key,
    required this.artObjPaths,
    required this.index,
  });

  final int index;
  final List<String> artObjPaths;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.DRAWING_PAGE,
          parameters: {'svgPath': artObjPaths[index]},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffFFF8EF),
          border: Border.all(color: const Color(0xffFF3838), width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: SvgPicture.asset(
          artObjPaths[index],
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}

import 'package:eso_akte_sikhi/app/modules/home/widgets/widgets.dart';
import 'package:eso_akte_sikhi/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/editor_page_controller.dart';

class EditorPageView extends GetView<EditorPageController> {
  const EditorPageView({super.key});
  final int numberOfImages = 8;
  List<String> get artObjPaths {
    return List<String>.generate(
      numberOfImages,
      (index) => 'assets/artObjs/artObj${index + 1}.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.orange, width: 10.0),
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
                  SizedBox(
                    width: Get.width / 1.2,
                    child: const Center(
                        child: Tex(
                            rcvd: 'SELECT DRAWING',
                            fsize: 25,
                            colo: Colors.red)),
                  )
                ],
              ),
              Container(
                height: 10,
                color: Colors.purple,
              ),
            ],
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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.OBJECT_EDITOR);
        },
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xffFFF8EF),
              border: Border.all(color: const Color(0xffFF3838), width: 2),
              borderRadius: BorderRadius.circular(15)),
          child: Image.asset(
            artObjPaths[index],
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}

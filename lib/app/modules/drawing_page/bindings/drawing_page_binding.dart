import 'package:get/get.dart';

import '../controllers/drawing_page_controller.dart';

class DrawingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawingPageController>(
      () => DrawingPageController(),
    );
  }
}

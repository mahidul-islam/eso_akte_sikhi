import 'package:get/get.dart';

import '../controllers/editor_page_controller.dart';

class EditorPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditorPageController>(
      () => EditorPageController(),
    );
  }
}

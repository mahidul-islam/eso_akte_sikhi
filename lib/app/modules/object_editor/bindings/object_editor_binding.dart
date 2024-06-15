import 'package:get/get.dart';

import '../controllers/object_editor_controller.dart';

class ObjectEditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ObjectEditorController>(
      () => ObjectEditorController(),
    );
  }
}

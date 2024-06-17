import 'package:get/get.dart';

class DrawingPageController extends GetxController {
  late final String svgPath;
  RxnInt selectedColorIndex = RxnInt();

  @override
  void onInit() {
    super.onInit();
    svgPath = Get.parameters['svgPath']!;
  }
}

import 'package:get/get.dart';

import '../modules/item_list/bindings/item_list_binding.dart';
import '../modules/item_list/views/item_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/drawing_page/bindings/drawing_page_binding.dart';
import '../modules/drawing_page/views/drawing_page_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ITEM_LIST,
      page: () => const ItemListView(),
      binding: ItemListBinding(),
    ),
    GetPage(
      name: _Paths.DRAWING_PAGE,
      page: () => const DrawingPageView(),
      binding: DrawingPageBinding(),
    ),
  ];
}

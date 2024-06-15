import 'package:get/get.dart';

import '../modules/editor_page/bindings/editor_page_binding.dart';
import '../modules/editor_page/views/editor_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/object_editor/bindings/object_editor_binding.dart';
import '../modules/object_editor/views/object_editor_view.dart';

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
      name: _Paths.EDITOR_PAGE,
      page: () => const EditorPageView(),
      binding: EditorPageBinding(),
    ),
    GetPage(
      name: _Paths.OBJECT_EDITOR,
      page: () => const ObjectEditorView(),
      binding: ObjectEditorBinding(),
    ),
  ];
}

import 'package:get/get.dart';

import '../modules/context_menu_demo/bindings/context_menu_demo_binding.dart';
import '../modules/context_menu_demo/views/context_menu_demo_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CONTEXT_MENU_DEMO;

  static final routes = [
    GetPage(
      name: _Paths.CONTEXT_MENU_DEMO,
      page: () => const ContextMenuDemoView(),
      binding: ContextMenuDemoBinding(),
    ),
  ];
}

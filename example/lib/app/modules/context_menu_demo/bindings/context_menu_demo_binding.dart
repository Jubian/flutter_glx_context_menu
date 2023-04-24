import 'package:get/get.dart';

import '../controllers/context_menu_demo_controller.dart';

class ContextMenuDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContextMenuDemoController>(
      () => ContextMenuDemoController(),
    );
  }
}

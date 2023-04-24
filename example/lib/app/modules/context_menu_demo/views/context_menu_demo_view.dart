import 'package:flutter/material.dart';
import 'package:flutter_glx_context_menu/flutter_glx_context_menu.dart';
import 'package:flutter_glx_utils/widget_chain/widget_chain.dart';

import 'package:get/get.dart';

import '../controllers/context_menu_demo_controller.dart';

class ContextMenuDemoView extends GetView<ContextMenuDemoController> {
  const ContextMenuDemoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GlxCtxMenuScaffold(
      appBar: AppBar(
          title: const Text('ContextMenuDemoView'),
          centerTitle: true,
        ),
      body: 
        [
          Container(
            color: Colors.red,
          )
          .intoGestureDetector(
            onSecondaryTapUp: (details) => controller.showMenu(details.globalPosition),
          )
          .intoExpanded(),

          Container(
            color: Colors.yellow,
            width: 300,
          )
          .intoGestureDetector(
            onSecondaryTapUp: (details) => controller.showMenu2(details.globalPosition),
          )
        ]
        .intoRow(),
          
      menuDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey, width: 0.5),
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5, spreadRadius: 1,offset: Offset(0, 4))]
      ),
    ); 
  }
}

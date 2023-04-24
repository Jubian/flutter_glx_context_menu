
import 'package:flutter/material.dart';
import 'package:flutter_glx_utils/widget_chain/widget_chain.dart';
import 'package:get/get.dart';

class GlxCtxMenuListView extends StatelessWidget {

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final Decoration? decoration;

  const GlxCtxMenuListView({super.key, required this.itemBuilder, required this.itemCount, this.padding,this.width,this.decoration});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics()
    )
    .intoContainer(
      color: decoration == null ? Theme.of(context).scaffoldBackgroundColor : null,
      constraints: BoxConstraints(
        maxHeight: Get.height - kToolbarHeight - kBottomNavigationBarHeight - 20,
      ),
      width: width,
      decoration: decoration,
      clipBehavior: decoration != null ? Clip.hardEdge :Clip.none
    );
  }
}
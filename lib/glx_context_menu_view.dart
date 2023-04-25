
import 'package:flutter/material.dart';
import 'glx_context_menu_item_view.dart';
import 'glx_context_menu_list_view.dart';
import 'package:flutter_glx_utils/widget_chain/widget_chain.dart';
import 'package:get/get.dart';
import 'glx_context_menu_controller.dart';
import 'glx_context_menu_item.dart';
import 'glx_context_menu_list.dart';

closeGlxContextMenu() {
  GlxContextMenuController.to.hideMenu();
}

showGlxContextMenu({required Offset position,required GlxCtxMenuList menuList, GlxCtxMenuTapCallback? tapCallback, bool closeOnTap = true}) {
  GlxContextMenuController.to.onTapItem = tapCallback;
  GlxContextMenuController.to.closeOnTap = closeOnTap;
  GlxContextMenuController.to.showMenu(position: position, menuList: menuList, level: 0);
}

class GlxContextMenuView extends GetView<GlxContextMenuController> {

  final EdgeInsetsGeometry padding;
  final double menuWidth;
  final Decoration? decoration;
  
  GlxContextMenuView({super.key, this.padding = const EdgeInsets.symmetric(vertical: 3), this.menuWidth = 150, this.decoration}) {
    Get.put(GlxContextMenuController());
    controller.menuGlobalWidth = menuWidth;
    controller.menuGlobalPadding = padding;
  }

  /// 显示菜单
  GlxCtxMenuListView _buildList(GlxCtxMenuList menuParam) {
    return GlxCtxMenuListView(
      key: menuParam.key,
      itemBuilder: (context, index) {
        return _buildItem(menuParam,index);
      },
      itemCount: menuParam.items.length,
      padding: menuParam.padding ?? padding,
      width: menuParam.menuWidth ?? menuWidth,
      decoration: menuParam.decoration ?? decoration,
    );
  }

  /// 构建菜单项
  Widget _buildItem(GlxCtxMenuList menuParam,int index) {
    final item = menuParam.items[index];
    if (item is GlxCtxMenuDivider) {
      // 分割线
      return GlxCtxMenuDividerView(
        height: item.height,
        horizonPadding: item.horizonPadding,
        verticalMargin: item.verticalMargin,
        color: item.color,
      );
    } else {
      // 自定义菜单项
      assert(item.title != null, 'title must not be null');
      return GlxCusCtxMenuItemView(
        key: item.itemKey,
        title: item.title!,
        trailing: item.trailing,
        horizonPadding: item.horizonPadding,
        verticalMargin: item.verticalMargin,
        selectColor: item.selectColor,
        isSelect: menuParam.selectIndex == index,
        height: item.height,
      )
      .onTap(() => controller.onTapMenuItem(item,menuParam,index))
      .intoMouseRegion(
        onEnter:(event) => controller.onEnterMenu(menuParam,index,item),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Obx(() {
      return controller.curShowList.map(
        (element)  {
          return _buildList(element)
          .intoPositioned(
            left: element.position.dx,
            top: element.position.dy,
          );
        }
      )
      .toList()
      .intoStack();
    });
    
  }
}
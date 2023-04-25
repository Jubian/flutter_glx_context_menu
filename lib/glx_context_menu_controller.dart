
import 'package:flutter/material.dart';
import 'package:flutter_glx_context_menu/glx_context_menu_item.dart';
import 'package:flutter_glx_context_menu/glx_context_menu_list.dart';
import 'package:get/get.dart';

enum GlxMenuShowDirect { right, left }

class GlxContextMenuController extends GetxController {

  static GlxContextMenuController to = Get.find<GlxContextMenuController>();

  /// 当前显示的菜单列表
  final curShowList = <GlxCtxMenuList>[].obs;
  /// 菜单栈key，用来获取菜单所属body的尺寸
  final stackKey = GlobalKey();
  /// 是否在点击事件后关闭菜单
  bool closeOnTap = true;
  /// 菜单item点击事件
  GlxCtxMenuTapCallback? onTapItem;

  /// width通用设置，未指定menuWidth时使用
  late double menuGlobalWidth;
  /// padding通用设置，未指定padding时使用
  late EdgeInsetsGeometry menuGlobalPadding;

  hideMenu({int fromLevel = 0, int toLevel = 1}) {
    if (fromLevel == 0) {
      curShowList.clear();
    } else {
      curShowList.removeRange(fromLevel, toLevel);
    }
  }

  showMenu({required Offset position,required GlxCtxMenuList menuList, required int level}) {
    if (level == 0) {
      hideMenu();
    }

    menuList.position = _calculatePositon(position: position, menuList: menuList);

    curShowList.add(menuList);
  }

  /// 当鼠标移入菜单
  onEnterMenu(GlxCtxMenuList menuParam, int index, GlxCtxMenuEntry item) {
    /// 指定当前选中的index
    menuParam.selectIndex = index;
    /// 如果有子菜单，显示子菜单
    if (item.subMenuList != null) {
      if (curShowList.firstWhereOrNull((menu) => menu.level == item.subMenuList!.level && menu.itemIndex == item.subMenuList!.itemIndex) != null) {
        return;
      }
      assert(item.itemKey != null, '子菜单必须指定key，否则无法获得子菜单的位置');
      final itemPosition = _getItemPosition(item.itemKey!);
      showMenu(position: itemPosition, menuList: item.subMenuList!, level: item.subMenuList!.level);
    }
    // 如果该菜单没有子菜单，则需要将已展示的子菜单移除
    else if(menuParam.level < curShowList.length - 1) {
      hideMenu(fromLevel: menuParam.level + 1, toLevel: curShowList.length);
    } 
    else {
      curShowList.refresh();
    }
  }

  /// 点击item
  onTapMenuItem(GlxCtxMenuEntry item, GlxCtxMenuList menuParam, int index) {
    if (item.data != null) {
      onTapItem?.call(menuParam.level,index,item.data);
      if (closeOnTap) hideMenu();
    }
  }
  

  /// 获取item在body中的位置
  Offset _getItemPosition(GlobalKey itemKey) {

    final RenderBox itemRenderBox = itemKey.currentContext!.findRenderObject()! as RenderBox;
    final Offset itemPosition = itemRenderBox.localToGlobal(Offset.zero);

    return itemPosition;
  }

  /// 计算menulist显示的position
  Offset _calculatePositon({required Offset position, required GlxCtxMenuList menuList}) {
    double positionX;
    double positionY;
    double screenWidth;
    double screenHeight;
    // 获取 body 部件的 RenderBox
    final bodyRenderBox = stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (bodyRenderBox != null) {
      // 转换为相对于 body 部件的本地坐标
      final positionOrigin =  bodyRenderBox.globalToLocal(position);
      positionX =  positionOrigin.dx;
      positionY = positionOrigin.dy;
      screenWidth = bodyRenderBox.size.width;
      screenHeight = bodyRenderBox.size.height;
    } else {
      positionX = position.dx;
      positionY = position.dy;
      screenWidth = Get.width;
      screenHeight = Get.height;
    }

    // 计算position，不能超过显示边界

    int level = menuList.level;

    double menuHeight = 0;

    for (var item in menuList.items) {
      // 计算菜单高度
      menuHeight += item.height;
      // verticalMargin是菜单项的上下margin，所以要乘以2
      menuHeight += (item.verticalMargin ?? 0)*2;
    }

    // 再加上list的上下padding
    final padding = menuList.padding ?? menuGlobalPadding;
    menuHeight += padding.vertical;

    final menuWidth = menuList.menuWidth ?? menuGlobalWidth;

    // 计算菜单显示方向和x坐标
    if (level == 0) {
      if (positionX + menuWidth > screenWidth) {
        positionX = screenWidth - menuWidth;
      }
    } else {
      Offset parentMenuPosition = curShowList[level - 1].position;
      double parentMenuWidth = curShowList[level - 1].menuWidth ?? menuGlobalWidth;

      // 计算右边的权重
      int rightWeight = calculateWeight(screenWidth, screenHeight, parentMenuPosition, parentMenuWidth, menuWidth, true);

      if (rightWeight > 0) {
        int leftWeight = calculateWeight(screenWidth, screenHeight, parentMenuPosition, parentMenuWidth, menuWidth, false);

        if (rightWeight <= leftWeight) {
          positionX = parentMenuPosition.dx + parentMenuWidth;
          if (positionX + menuWidth > screenWidth) {
            positionX = screenWidth - menuWidth;
          }
        } else {
          positionX = parentMenuPosition.dx - menuWidth;
        }
      } else {
        positionX = parentMenuPosition.dx + parentMenuWidth;
      }
    }

    // 计算y坐标
    if (positionY + menuHeight > screenHeight) {
      positionY = screenHeight - menuHeight;
    }

    return Offset(positionX, positionY);

  }

  /// 计算菜单显示的权重，权重越大，越不适合显示,
  /// 0表示最适合显示, 
  /// 1表示遮挡住了其他的菜单，
  /// 2表示超出了屏幕，
  /// 3表示超出了屏幕并且遮挡住了其他的菜单
  int calculateWeight(double screenWidth, double screenHeight, Offset parentMenuPosition, double parentMenuWidth, double menuWidth, bool isRight) {
    double menuX;
    if (isRight) {
      menuX = parentMenuPosition.dx + parentMenuWidth;
    } else {
      menuX = parentMenuPosition.dx - menuWidth;
    }

    int weight = 0;
    // 计算是否超出屏幕
    if (menuX < 0 || menuX + menuWidth > screenWidth) {
      weight += 2;
    }

    // 计算遮挡的菜单
    for (final menu in curShowList) {
      double menuRightX = menu.position.dx + (menu.menuWidth ?? menuGlobalWidth);
      if (isRight) {
        if (menu.position.dx < menuX + menuWidth && menuRightX > menuX) {
          weight += 1;
        }
      } else {
        if (menu.position.dx < menuX && menuRightX > menuX - menuWidth) {
          weight += 1;
        }
      }
    }

    return weight;
  }
  
}
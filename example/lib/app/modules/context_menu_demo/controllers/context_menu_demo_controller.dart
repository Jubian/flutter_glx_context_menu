import 'package:flutter/material.dart';
import 'package:flutter_glx_context_menu/flutter_glx_context_menu.dart';
import 'package:get/get.dart';

class ContextMenuDemoController extends GetxController {

  showMenu(Offset position) {
    
    showGlxContextMenu(
      tapCallback: (level, index, data) => print(data),
      position: position,
      menuList: GlxCtxMenuList(
        itemIndex: 0,
        level: 0,
        itemBuilder: (index) {
          if (index == 1) {
            /// 子菜单
            return GlxCtxSubItemsMenuItem(
              titleText: '1111 $index',
              subMenuList: GlxCtxMenuList(
                itemIndex: index,
                menuWidth: 200,
                level: 1,
                itemBuilder: (index) {
                  if (index == 2) {
                    return GlxCtxSubItemsMenuItem(
                      titleText: '2222 $index',
                      subMenuList: GlxCtxMenuList(
                        itemIndex: index,
                        level: 2,
                        itemBuilder: (index) => GlxCtxTextMenuItem(titleText: 'titleTexttitleTexttitleTexttitleTexttitleText $index'),
                        itemCount: 3
                      )
                    );
                  }
                  return GlxCtxTextMenuItem(
                    titleText: 'titleTexttitleTexttitleTexttitleTexttitleText $index',
                  );
                },
                itemCount: 3
              )
            );
          } else {
            return GlxCtxTextMenuItem(
              data: 'data $index',
              horizonPadding: 10,
              height: 30,
              titleText: 'titleText $index',
              trailingText: 'trailingTexttrailingTexttrailingTexttrailingText $index'
            );
          }
        },
        itemCount: 10
      )
    );
  }

  showMenu2(Offset position) {
    
    showGlxContextMenu(
      position: position,
      menuList: GlxCtxMenuList(
        itemIndex: 0,
        level: 0,
        itemBuilder: (index) {
          if (index == 0) {
            /// 子菜单
            return GlxCtxSubItemsMenuItem(
              titleText: '1111 $index',
              subMenuList: GlxCtxMenuList(
                itemIndex: index,
                level: 1,
                itemBuilder: (index) => GlxCtxTextMenuItem(titleText: 'titleTexttitleTexttitleTexttitleTexttitleText $index'),
                itemCount: 3
              )
            );
          }
          return GlxCtxTextMenuItem(titleText: 'titleText $index');
        },
        itemCount: 5
      )
    );
  }
}

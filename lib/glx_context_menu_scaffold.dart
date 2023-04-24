// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glx_context_menu/glx_context_menu_controller.dart';
import 'package:flutter_glx_utils/widget_chain/widget_chain.dart';

import 'glx_context_menu_view.dart';

/// 自定义scaffold

class GlxCtxMenuScaffold extends StatelessWidget {

    /// scaffold
    final PreferredSizeWidget? appBar;
    final Widget body;
    final Widget? floatingActionButton;
    final FloatingActionButtonLocation? floatingActionButtonLocation;
    final FloatingActionButtonAnimator? floatingActionButtonAnimator;
    final List<Widget>? persistentFooterButtons;
    final AlignmentDirectional persistentFooterAlignment;
    final Widget? drawer;
    final void Function(bool)? onDrawerChanged;
    final Widget? endDrawer;
    final void Function(bool)? onEndDrawerChanged;
    final Widget? bottomNavigationBar;
    final Widget? bottomSheet;
    final Color? backgroundColor;
    final bool? resizeToAvoidBottomInset;
    final bool primary;
    final DragStartBehavior drawerDragStartBehavior;
    final bool extendBody;
    final bool extendBodyBehindAppBar;
    final Color? drawerScrimColor;
    final double? drawerEdgeDragWidth;
    final bool drawerEnableOpenDragGesture;
    final bool endDrawerEnableOpenDragGesture;
    final String? restorationId;

    /// context menu
    final Key? menuKey;
    final Decoration? menuDecoration;
    final EdgeInsetsGeometry menuPadding;
    final double menuWidth;

  const GlxCtxMenuScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.menuKey,
    this.menuDecoration,
    this.menuPadding = const EdgeInsets.symmetric(vertical: 3),
    this.menuWidth = 150
  });

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        key: key,
        appBar: appBar,
        body: [
          body,
          GlxContextMenuView(
            key: menuKey,
            padding: menuPadding,
            menuWidth: menuWidth,
            decoration: menuDecoration,
          )
        ]
        .intoStack(
          key: GlxContextMenuController.to.stackKey
        ),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        persistentFooterButtons: persistentFooterButtons,
        persistentFooterAlignment: persistentFooterAlignment,
        drawer: drawer,
        onDrawerChanged: onDrawerChanged,
        endDrawer: endDrawer,
        onEndDrawerChanged: onEndDrawerChanged,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        primary: primary,
        drawerDragStartBehavior: drawerDragStartBehavior,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        drawerScrimColor: drawerScrimColor,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        restorationId: restorationId,
      )
      .intoListener(
        onPointerDown: (event) {
          for (var element in GlxContextMenuController.to.curShowList) {
            final menuListBox = element.key.currentContext?.findRenderObject() as RenderBox?;
            if (menuListBox != null) {
              final menuListRect = menuListBox.localToGlobal(Offset.zero) & menuListBox.size;
              if (menuListRect.contains(event.position)) {
                return;
              }
            }
          }
          closeGlxContextMenu();
        }
      );    
  }
  
}

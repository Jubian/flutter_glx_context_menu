
import 'glx_context_menu_item.dart';
import 'package:flutter/material.dart';

/// 菜单参数
class GlxCtxMenuList {
  /// 构建菜单项
  final GlxCtxMenuBuilder itemBuilder;
  /// 菜单项数量
  final int itemCount;
  /// 列表key
  final key = GlobalKey();
  /// 列表宽度
  final double? menuWidth;
  /// 列表padding
  final EdgeInsetsGeometry? padding;
  /// 列表效果
  final Decoration? decoration;
  /// 第几级菜单
  final int level;
  /// 处于第几个item
  final int itemIndex;

  /// 选中的index
  var selectIndex = -1;
  /// 菜单位置
  var position = Offset.zero;

  GlxCtxMenuList({
    required this.itemBuilder,
    required this.itemCount,
    required this.level,
    required this.itemIndex,
    this.menuWidth,
    this.padding,
    this.decoration
    });
}
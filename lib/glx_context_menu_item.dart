
import 'package:flutter/material.dart';
import 'package:flutter_glx_utils/tool/string_util.dart';
import 'package:flutter_glx_utils/widget_chain/widget_chain.dart';
import 'package:get/get.dart';
import 'glx_context_menu_list.dart';

typedef GlxCtxMenuTapCallback = void Function(int level, int index, dynamic data);

/// menuItem 基类
abstract class GlxCtxMenuEntry {
  
  double get height;
  
  Widget? get title;

  Widget? get trailing;

  double? get horizonPadding;

  double? get verticalMargin;

  Color? get selectColor;

  GlxCtxMenuList? get subMenuList;

  GlobalKey? itemKey;

  dynamic get data;

}

/// 分割线
class GlxCtxMenuDivider extends GlxCtxMenuEntry {
  
  Color? color;
  @override
  double height;
  @override
  double horizonPadding;
  @override
  double verticalMargin;

  GlxCtxMenuDivider({this.height = 1,this.horizonPadding = 0,this.color,this.verticalMargin = 2});
  
  @override
  Widget? get title => null;
  
  @override
  Widget? get trailing => null;
      
  @override
  Color? get selectColor => null;
    
  @override
  GlxCtxMenuList? get subMenuList => null;
  
  @override
  get data => null;

}

/// 带子菜单的menuItem
class GlxCtxSubItemsMenuItem extends GlxCtxMenuEntry{
  String titleText;
  TextStyle? textStyle;
  String? imgName;
  Size? imgSize;
  @override
  double horizonPadding;
  @override
  double? verticalMargin;
  @override
  GlxCtxMenuList subMenuList;
  @override
  Color? selectColor;
  @override
  double height;
  

  GlxCtxSubItemsMenuItem({
    required this.titleText,
    required this.subMenuList,
    this.textStyle,
    this.imgName,
    this.imgSize,
    this.horizonPadding = 5,
    this.verticalMargin,
    this.selectColor,
    this.height = 30,
  }) {
    itemKey = GlobalKey();
  }
  
  @override
  Widget get title => Text(titleText,style: textStyle ?? Theme.of(Get.context!).textTheme.bodyLarge,maxLines: 1,overflow: TextOverflow.ellipsis,).intoExpanded();
  
  @override
  Widget? get trailing {
    if (StringUtil.isNotEmpty(imgName)) {
      return Image.asset(imgName!,width: imgSize?.width,height: imgSize?.height);
    } else {
      return const Icon(Icons.chevron_right,size: 22,);
    }
  }
  
  @override
  get data => null;
  
}

/// 纯文字的menuItem
class GlxCtxTextMenuItem extends GlxCtxMenuEntry{
  String titleText;
  TextStyle? textStyle;
  String? trailingText;
  TextStyle? trailingTextStyle;
  @override
  double horizonPadding;
  @override
  double? verticalMargin;
  @override
  Color? selectColor;
  @override
  double height;
  @override
  dynamic data;

  GlxCtxTextMenuItem({
    required this.titleText,
    this.textStyle,
    this.trailingText,
    this.trailingTextStyle,
    this.horizonPadding = 5,
    this.verticalMargin,
    this.selectColor,
    this.height = 30,
    this.data
  });
  
  @override
  Widget get title =>  Text(titleText,style: textStyle ?? Theme.of(Get.context!).textTheme.bodyLarge,maxLines: 1,overflow: TextOverflow.ellipsis);
  
  @override
  Widget? get trailing {
    if (StringUtil.isNotEmpty(trailingText)) {
      return Text(trailingText!,style: trailingTextStyle ?? Theme.of(Get.context!).textTheme.bodyLarge,maxLines: 1,overflow: TextOverflow.ellipsis).intoExpanded();
    } else {
      return null;
    }
  }
  
  @override
  GlxCtxMenuList? get subMenuList => null;
  
}
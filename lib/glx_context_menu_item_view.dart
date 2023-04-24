import 'package:flutter/material.dart';
import 'package:flutter_glx_utils/widget/glx_simple_widget.dart';
import 'package:flutter_glx_utils/widget_chain/widget_chain.dart';

/// menuItem 基类
abstract class GlxCtxMenuViewEntry extends StatelessWidget {
  const GlxCtxMenuViewEntry({super.key});
  
  double? get height;

  Widget? get title;

  Widget? get trailing;

}

/// 分割线
class GlxCtxMenuDividerView extends GlxCtxMenuViewEntry {

  const GlxCtxMenuDividerView({super.key, this.height = 1,this.color,this.horizonPadding = 0,this.verticalMargin = 2});

  final double horizonPadding;
  final double verticalMargin;
  final Color? color;

  @override
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 0,
      endIndent: 0,
      height: height,
      color: color ?? Theme.of(context).dividerColor,
    )
    .intoPadding(padding: EdgeInsets.symmetric(horizontal: horizonPadding,vertical: verticalMargin));
  }
  
  @override
  Widget? get title => null;
  
  @override
  Widget? get trailing => null;

}

/// 自定义 menuItem
class GlxCusCtxMenuItemView extends GlxCtxMenuViewEntry {
  @override
  final Widget title;
  @override
  final Widget? trailing;
  @override
  final double? height;
  final double? horizonPadding;
  final double? verticalMargin;
  final Color? selectColor;
  final bool isSelect;

   const GlxCusCtxMenuItemView({
    super.key,
    required this.title,
    required this.height,
    this.trailing,
    this.horizonPadding,
    this.verticalMargin,
    this.selectColor,
    this.isSelect = false,
  });

  Widget _content() {
    if (trailing == null) {
      return title;
    } else {
      return [
        title,
        glx_sb_w(10),
        trailing!
      ]
      .intoRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _content()
    .intoContainer(
      alignment: Alignment.centerLeft,
      height: height,
      padding: horizonPadding != null ? EdgeInsets.symmetric(horizontal: horizonPadding!) : null,
      margin: verticalMargin != null ? EdgeInsets.symmetric(vertical: verticalMargin!) : null,
      decoration: BoxDecoration(
        color: isSelect ? selectColor ?? Theme.of(context).primaryColor :  Colors.transparent,
      ),
    );
  }

}
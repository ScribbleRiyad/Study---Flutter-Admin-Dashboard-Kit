import 'package:flutter/material.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/my_shadow.dart';
import 'package:study/helpers/widgets/my_constant.dart';
import 'package:study/helpers/widgets/my_spacing.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final double? borderRadiusAll, paddingAll, marginAll;
  final EdgeInsetsGeometry? padding, margin;
  final Color? color;
  final GestureTapCallback? onTap;
  final bool bordered;
  final Border? border;
  final Clip? clipBehavior;
  final BoxShape? boxShape;
  final MyShadow? shadow;
  final double? width, height;
  final Color? splashColor;

  const MyCard(
      {super.key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll,
      this.color,
      this.paddingAll,
      this.onTap,
      this.border,
      this.bordered = false,
      this.clipBehavior,
      this.boxShape,
      this.shadow,
      this.marginAll,
      this.margin,
      this.splashColor,
      this.width,
      this.height});

  const MyCard.bordered(
      {super.key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll,
      this.color,
      this.paddingAll,
      this.onTap,
      this.border,
      this.bordered = true,
      this.clipBehavior,
      this.boxShape,
      this.shadow,
      this.marginAll,
      this.margin,
      this.splashColor,
      this.width,
      this.height});

  const MyCard.circular(
      {super.key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll,
      this.color,
      this.paddingAll,
      this.onTap,
      this.border,
      this.bordered = false,
      this.clipBehavior = Clip.antiAliasWithSaveLayer,
      this.boxShape,
      this.shadow,
      this.marginAll,
      this.margin,
      this.splashColor,
      this.width,
      this.height});

  const MyCard.none(
      {super.key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll = 0,
      this.color,
      this.paddingAll = 0,
      this.onTap,
      this.border,
      this.bordered = false,
      this.clipBehavior = Clip.antiAliasWithSaveLayer,
      this.boxShape = BoxShape.rectangle,
      this.shadow,
      this.marginAll,
      this.margin,
      this.splashColor,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    MyShadow myShadow = shadow ?? MyShadow();
    return InkWell(
      borderRadius: boxShape != BoxShape.circle
          ? borderRadius ??
              BorderRadius.all(Radius.circular(
                  borderRadiusAll ?? MyConstant.constant.cardRadius))
          : null,
      splashColor: splashColor ?? Colors.transparent,
      highlightColor: splashColor ?? Colors.transparent,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin ?? MySpacing.all(marginAll ?? 0),
        decoration: BoxDecoration(
            color: color ?? theme.cardTheme.color,
            borderRadius: boxShape != BoxShape.circle
                ? borderRadius ??
                    BorderRadius.all(Radius.circular(
                        borderRadiusAll ?? MyConstant.constant.cardRadius))
                : null,
            border: bordered
                ? border ?? Border.all(color: theme.dividerColor, width: 1)
                : null,
            shape: boxShape ?? BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                  color: myShadow.color ??
                      theme.shadowColor.withAlpha(myShadow.alpha),
                  spreadRadius: myShadow.spreadRadius,
                  blurRadius: myShadow.blurRadius,
                  offset: myShadow.offset!)
            ]),
        padding: padding ?? MySpacing.all(paddingAll ?? 16),
        clipBehavior: clipBehavior ?? Clip.none,
        child: child,
      ),
    );
  }
}

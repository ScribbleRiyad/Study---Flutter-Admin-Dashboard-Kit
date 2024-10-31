import 'package:flutter/material.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/widgets/my_constant.dart';
import 'package:study/helpers/widgets/my_screen_media.dart';
import 'package:study/helpers/widgets/my_text_style.dart';

class My {
  // entry point of the package
  init() {}

  static void changeTheme(ThemeData theme) {
    AppTheme.theme = theme;
  }

  static void setTextDirection(TextDirection direction) {
    AppTheme.textDirection = direction;
  }

  static void changeFontFamily(GoogleFontFunction fontFamily) {
    MyTextStyle.changeFontFamily(fontFamily);
  }

  static void changeDefaultFontWeight(Map<int, FontWeight> defaultFontWeight) {
    MyTextStyle.changeDefaultFontWeight(defaultFontWeight);
  }

  static void changeDefaultTextFontWeight(
      Map<MyTextType, int> defaultFontWeight) {
    MyTextStyle.changeDefaultTextFontWeight(defaultFontWeight);
  }

  static void changeDefaultTextSize(Map<MyTextType, double> defaultTextSize) {
    MyTextStyle.changeDefaultTextSize(defaultTextSize);
  }

  static void changeDefaultLetterSpacing(
      Map<MyTextType, double> defaultLetterSpacing) {
    MyTextStyle.changeDefaultLetterSpacing(defaultLetterSpacing);
  }

  static setConstant(MyConstantData constantData) {
    MyConstant.setConstant(constantData);
  }

  static setFlexSpacing(double spacing) {
    MyScreenMedia.flexSpacing = spacing;
  }

  static setFlexColumns(int columns) {
    MyScreenMedia.flexColumns = columns;
  }
}
